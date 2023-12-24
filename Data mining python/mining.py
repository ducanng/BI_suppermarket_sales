import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt

from sklearn.preprocessing import LabelEncoder
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
from sklearn.metrics import ConfusionMatrixDisplay
# Kết nối với OLAP Cube và đọc dữ liệu
# Thực hiện truy vấn SQL hoặc tương tự để lấy dữ liệu từ OLAP Cube vào DataFrame của Pandas
# data = pd.read_sql("SELECT * FROM YourOLAPTable", connection)
import pyodbc

# Kết nối đến Cube OLAP
conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=MSI;DATABASE=dds;Trusted_Connection=yes;')

# Tạo một đối tượng cursor
cursor = conn.cursor()

#Dự đoán kết quả mua hàng của khách hàng có phải theo từng loại sản phẩm. 
#Output: loai san pham(idproductline)
#Input: unitPrice(product_DIM),Quantity(fact),rating(fact),gender(invoice_dim)
query="select p.unitPrice, i.gender, f.Quantity, f.rating, p.productline from factproductsales f join dimInvoice i on f.invoiceid = i.invoiceid join dimProduct p on f.productID=p.productID"
cursor.execute(query)

# Lấy kết quả của truy vấn
rows = cursor.fetchall()

# In ra kết quả
# for row in rows:
#     print(row)

# Biến đổi dữ liệu thành DataFrame

data = pd.read_sql(query, conn)
#print(data)

# Tạo một đối tượng LabelEncoder
label_encoder = LabelEncoder()

# Chuyển đổi cột gender thành dạng số
data['gender_encoded'] = label_encoder.fit_transform(data['gender'])

# Loại bỏ cột gender ban đầu nếu cần
data.drop('gender', axis=1, inplace=True)


data['productline_encoded'] = label_encoder.fit_transform(data['productline'])
#data.drop('productline', axis=1, inplace=True)

# Gán features và label
features = ['unitPrice', 'gender_encoded', 'Quantity', 'rating']
label = 'productline_encoded'

# Tạo một từ điển ánh xạ giá trị gốc sang giá trị đã được encode
mapping = {i: index for index, i in enumerate(label_encoder.classes_)}

# In ra giá trị gốc: giá trị đã được encode
for i, encoded in mapping.items():
    original_value = label_encoder.inverse_transform([encoded])[0]
    print(f"{data['productline_encoded'][data['productline'] == original_value].values[0]}: {original_value}")


X = data[features]
y = data[label]


# Chia dữ liệu thành tập train và test (ví dụ: 80% train, 20% test)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#-----------------Xây dựng và huấn luyện mô hình (sử dụng Decision Tree Classifier)---------------------


model = DecisionTreeClassifier()
model.fit(X_train, y_train)

# Dự đoán trên tập test
predictions = model.predict(X_test)

# Đánh giá mô hình
from sklearn.metrics import accuracy_score

accuracy = accuracy_score(y_test, predictions)
print("Accuracy:", accuracy)

#################---Random Forest---- và ma trận confusion###################
# Khởi tạo mô hình Random Forest
rf_model = RandomForestClassifier(n_estimators=100, random_state=42)

# Huấn luyện mô hình trên tập train
rf_model.fit(X_train, y_train)
# Tính toán ma trận confusion
conf_matrix = confusion_matrix(y_test, rf_model.predict(X_test))  # Tính toán confusion matrix

# Hiển thị ma trận confusion
disp = ConfusionMatrixDisplay(confusion_matrix=conf_matrix, display_labels=rf_model.classes_)
disp.plot(cmap='Blues')  # Chọn màu sắc (có thể thay đổi)
plt.title('Confusion Matrix of Random Forest Model')
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.show()

#Ma trận confusion giúp bạn hiểu rõ hơn về khả năng dự đoán của mô hình cho từng nhãn (sản phẩm) cụ thể,
# và từ đó đánh giá hiệu suất của mô hình trong việc phân loại các sản phẩm.

# o muc diem 17%, Ket luan co the dua ra la khach hang mua hang khong phu thuoc vao loai san pham. Tuy nhien day chi mang tinh chat tham khao  

