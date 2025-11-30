from PIL import Image
import os

# المسار إلى الشعار الأصلي الذي تم رفعه
INPUT_IMAGE_PATH = "assets/logo.png"

# مسارات Android
ANDROID_RES_PATH = "android/app/src/main/res/"
ANDROID_MIPMAP_PATHS = {
    "mipmap-mdpi": 48,
    "mipmap-hdpi": 72,
    "mipmap-xhdpi": 96,
    "mipmap-xxhdpi": 144,
    "mipmap-xxxhdpi": 192,
}

# مسارات iOS
IOS_ASSETS_PATH = "ios/Runner/Assets.xcassets/AppIcon.appiconset/"
IOS_SIZES = [
    (20, 2), (20, 3),
    (29, 2), (29, 3),
    (40, 2), (40, 3),
    (60, 2), (60, 3),
    (76, 2),
    (83.5, 2),
]

def generate_android_icons():
    print("بدء توليد أيقونات Android...")
    try:
        img = Image.open(INPUT_IMAGE_PATH)
    except FileNotFoundError:
        print(f"خطأ: لم يتم العثور على ملف الشعار في {INPUT_IMAGE_PATH}")
        return

    for folder, size in ANDROID_MIPMAP_PATHS.items():
        output_dir = os.path.join(ANDROID_RES_PATH, folder)
        os.makedirs(output_dir, exist_ok=True)
        output_path = os.path.join(output_dir, "ic_launcher.png")
        
        resized_img = img.resize((size, size), Image.Resampling.LANCZOS)
        resized_img.save(output_path)
        print(f"تم توليد: {output_path} بحجم {size}x{size}")
    print("اكتمل توليد أيقونات Android.")

def generate_ios_icons():
    print("بدء توليد أيقونات iOS...")
    try:
        img = Image.open(INPUT_IMAGE_PATH)
    except FileNotFoundError:
        print(f"خطأ: لم يتم العثور على ملف الشعار في {INPUT_IMAGE_PATH}")
        return

    os.makedirs(IOS_ASSETS_PATH, exist_ok=True)
    
    # قراءة ملف Contents.json لتحديد أسماء الملفات المطلوبة
    json_path = os.path.join(IOS_ASSETS_PATH, "Contents.json")
    if not os.path.exists(json_path):
        print(f"خطأ: لم يتم العثور على ملف {json_path}")
        return

    import json
    with open(json_path, 'r') as f:
        contents = json.load(f)

    for image_info in contents.get('images', []):
        try:
            size_str = image_info['size'].split('x')[0]
            scale_str = image_info['scale'].replace('x', '')
            filename = image_info['filename']
            
            size = int(float(size_str))
            scale = int(scale_str)
            
            final_size = size * scale
            output_path = os.path.join(IOS_ASSETS_PATH, filename)
            
            resized_img = img.resize((final_size, final_size), Image.Resampling.LANCZOS)
            resized_img.save(output_path)
            print(f"تم توليد: {output_path} بحجم {final_size}x{final_size}")
        except KeyError:
            # تجاهل الإدخالات التي لا تحتوي على معلومات كافية
            continue
        except ValueError:
            # تجاهل الإدخالات التي لا يمكن تحويلها إلى أرقام
            continue

    print("اكتمل توليد أيقونات iOS.")

if __name__ == "__main__":
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    generate_android_icons()
    generate_ios_icons()
