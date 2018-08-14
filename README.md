# DreamLister
Learn How To Use Core Data 
1. Tạo Entity, relationship qua file .xcdatamodeld
2. Tạo model của các entity là các NSManagedObject có thể lấy data từ entity coi nó là 1 object và làm việc trực tiếp 
3. Tạo biến toàn cục appDel = UIApplication.shared.delegate as! AppDelegate 
và context = appDel.persistentContainer.viewContext dùng để có thể quản lý data là các NSManagedobjet như lấy dữ liệu, thêm, xoá, lưu lại.
4. Dùng NSFetchedResultsControllerDelegate để lấy dữ liệu vào các object, cách nó quản lý được tối ưu để kết hợp với UITableView rất tiện dụng.

Làm việc với @IBInspectable @IBDesignable , extension các thành phần như UIView, UITextField 

Lấy ảnh thông qua UIImagePickerController
