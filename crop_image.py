from PIL import Image

# المسار إلى الصورة المرفقة
input_path = '/home/ubuntu/upload/IMG_20251130_044548.jpg'
# المسار لحفظ الأيقونة المقتطعة
output_path = '/home/ubuntu/Ratlozen-Services/assets/empty_cart_icon.png'

try:
    img = Image.open(input_path)
    
    # تقدير إحداثيات الاقتصاص (بناءً على تحليل الصورة المرفقة)
    # الأيقونة تقع في الجزء العلوي الأوسط.
    # سأفترض أن الأيقونة تبدأ من حوالي 20% من العرض و 10% من الارتفاع، وتنتهي عند 80% من العرض و 40% من الارتفاع.
    width, height = img.size
    
    # إحداثيات الاقتصاص (x_min, y_min, x_max, y_max)
    # سأستخدم قيم تقريبية بناءً على شكل الصورة
    x_min = int(width * 0.25)
    y_min = int(height * 0.10)
    x_max = int(width * 0.75)
    y_max = int(height * 0.45)
    
    cropped_img = img.crop((x_min, y_min, x_max, y_max))
    
    # حفظ الصورة المقتطعة
    cropped_img.save(output_path)
    
    print(f"تم اقتصاص الصورة وحفظها في: {output_path}")

except Exception as e:
    print(f"حدث خطأ: {e}")
