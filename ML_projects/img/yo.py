import streamlit as st
from PIL import Image
import numpy as np
import cv2
import random
import zipfile
from io import BytesIO
import itertools

# Background style
st.markdown("""
    <style>
    .stApp {
        background-image: url("https://wallpaperaccess.com/full/4600302.jpg");
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
    }
    </style>
    """, unsafe_allow_html=True)

#st.set_page_config(page_title="home")
st.title("Augmented Image Generater")
col1,col2 =st.columns(2)
source = col1.file_uploader(label="Drop an image to augment",type=["jpg", "jpeg", "png"],label_visibility="visible")

def load_image(img):
    im = Image.open(img)
    image = np.array(im)
    return image


if source is not None:
    img = load_image(source)
    col1.image(img)
    col1.write("Image Uploaded Successfully")

else:
    st.write("Make sure you image is in JPG/PNG Format.")

options=col2.multiselect(label="""Select types affine transformation to perform on image. """,
                         options=["Translation","Scaling","Rotation","Shearing","Cropping","RGB2GRAY"],
                        default="RGB2GRAY",label_visibility="visible")

no_of_pics=col2.number_input(label="pick number of augmented pictures to generate",min_value=0,max_value=100,step=1)

def img2gray(img):
    return cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)


def random_affine_matrix(img_shape):
    h, w = img_shape[:2]
    
    if "Scaling" in options:
        # Random scaling
        sx = np.random.uniform(0.9, 1.1)
        sy = np.random.uniform(0.9, 1.1)
    else:
        sx = 1.0
        sy = 1.0

    if "Shearing" in options:
        # Random shear
        shx = np.random.uniform(-0.2, 0.2)
        shy = np.random.uniform(-0.2, 0.2)
    else:
        shx = 0.0
        shy = 0.0
    
    if "Translation" in options:
        # Random translation (up to ±20% of dimensions)
        tx = np.random.uniform(-0.2 * w, 0.2 * w)
        ty = np.random.uniform(-0.2 * h, 0.2 * h)
    else:
        tx = 0.0
        ty = 0.0

    matrix = np.array([
        [sx, shx, tx],
        [shy, sy, ty]
    ], dtype=np.float32)

    return matrix

def rotation_matrix(img):
    deg=np.random.uniform(-30,30)
    x = np.random.uniform(1, 2)
    y = np.random.uniform(1, 2)
    return cv2.getRotationMatrix2D((img.shape[0]//x,img.shape[1]//y),deg,1)


def flip(img):
    return cv2.flip(img, 1)

def apply_cropping(img):
    h, w = img.shape[:2]
    crop_percent = random.uniform(0.1, 0.2)
    return img[int(h * crop_percent):int(h * (1 - crop_percent)), int(w * crop_percent):int(w * (1 - crop_percent))]

def random_transformation(opt):
    try:
        return random.choice(opt)
    except:
        return "select a transformation method"

def brightness_change(img):
    brightness_value = np.random.uniform(50, 200)
    delta = np.full(img.shape, brightness_value, dtype=np.uint8)

    brighter = cv2.add(img, delta)
    darker = cv2.subtract(img, delta)

    return random.choice([brighter, darker])


def wrap(img,aug_matrix):
    return cv2.warpAffine(img,aug_matrix,(img.shape[1],img.shape[0]),borderMode=cv2.BORDER_REPLICATE)

def create_zip_from_images(images_dict):
    zip_buffer = BytesIO()
    with zipfile.ZipFile(zip_buffer, "w") as zip_file:
        for name, img_bytes in images_dict.items():
            zip_file.writestr(name, img_bytes)
    zip_buffer.seek(0)
    return zip_buffer

def convert_image_to_bytes(img_array, is_gray=False):
    img = Image.fromarray(img_array).convert("L" if is_gray else "RGB")
    buffer = BytesIO()
    img.save(buffer, format="PNG")
    buffer.seek(0)
    return buffer.read()

if st.button("Generate") and source and options:
    zip_img = {}
    
    for c in range(no_of_pics):
        img = load_image(source)
        
        # Randomly decide which selected transforms to apply this time
        current_combo = {opt: random.choice([True, False]) for opt in options}

        if any(current_combo.get(k, False) for k in ["Translation", "Scaling", "Shearing"]):
            rm = random_affine_matrix(img.shape)
            img = wrap(img, rm)

        if current_combo.get("Rotation"):
            rm = rotation_matrix(img)
            img = wrap(img, rm)

        if current_combo.get("Cropping"):
            img = apply_cropping(img)

        if current_combo.get("RGB2GRAY"):
            img = img2gray(img)

        img = brightness_change(img)
        img = flip(img)

        zip_img[f"img{c}.png"] = convert_image_to_bytes(img)

    if zip_img:
        zip_file = create_zip_from_images(zip_img)
        st.download_button(
            label="📦 Download All Augmented Images (ZIP)",
            data=zip_file,
            file_name="augmented_images.zip",
            mime="application/zip"
        )
