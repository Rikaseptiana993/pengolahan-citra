import os
import cv2
import matplotlib.pyplot as plt 
from random import shuffle #membaca folder (label)sebagai kelas mobil yang berbeda

# --- Set path ke dataset ---
dataset_path = 'dataset/Images/train'
labels = sorted(os.listdir(dataset_path))

print("📁 Daftar kelas mobil dalam dataset:")
for l in labels:
    print(" -", l)
print()

# --- Ambil input gambar ---
input_path = input("🖼️ Masukkan path ke citra yang ingin diuji (misal: tes.jpg): ").strip()

if not os.path.exists(input_path):
    print("❌ Gambar tidak ditemukan!")
    exit()

# --- Siapkan gambar input ---
input_img = cv2.imread(input_path)
input_img = cv2.resize(input_img, (300, 300)) #input gambar dari user dan diubah ke ukuran standar 300x300
input_img_gray = cv2.cvtColor(input_img, cv2.COLOR_BGR2GRAY) #Diubah ke grayscale karena ekstraksi fitur lebih efisien di gambar hitam-putih.

# --- Inisialisasi ORB ---
orb = cv2.ORB_create() #ORB mendeteksi keypoints (titik-titik penting) dan menghasilkan deskriptor, yaitu representasi fitur dari gambar tersebut.
kp1, des1 = orb.detectAndCompute(input_img_gray, None)

if des1 is None or len(kp1) < 10:
    print("❌ Gambar input tidak memiliki cukup fitur untuk dibandingkan.")
    exit()

# --- Ambil daftar semua gambar dari semua label ---
image_list = []
for label in labels:
    folder_path = os.path.join(dataset_path, label)
    for filename in os.listdir(folder_path):
        image_path = os.path.join(folder_path, filename)
        image_list.append((image_path, label))

shuffle(image_list)  # acak urutan gambar
image_list = image_list[:100]  # ambil 100 gambar saja

# --- Matcher ---
bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

# --- Variabel hasil terbaik ---
most_similar_label = None
most_similar_path = None
max_matches = 0

# --- Loop 100 gambar terpilih ---
for image_path, label in image_list:
    dataset_img = cv2.imread(image_path)
    if dataset_img is None:
        continue

    dataset_img = cv2.resize(dataset_img, (300, 300))
    dataset_img_gray = cv2.cvtColor(dataset_img, cv2.COLOR_BGR2GRAY)

    kp2, des2 = orb.detectAndCompute(dataset_img_gray, None)
    if des2 is None or len(kp2) < 10:
        continue

    matches = bf.match(des1, des2)
    matches = sorted(matches, key=lambda x: x.distance)
#Menggunakan BFMatcher (Brute Force Matcher) untuk mencocokkan deskriptor dari gambar input dan dataset.

    if len(matches) > max_matches: #Program menyimpan gambar dengan jumlah kecocokan fitur terbanyak sebagai gambar yang paling mirip.
        max_matches = len(matches)
        most_similar_label = label
        most_similar_path = image_path
        best_dataset_img = dataset_img
#Gambar dari dataset juga diubah ukurannya dan diambil deskriptornya menggunakan ORB.

# --- Tampilkan hasil ---
if most_similar_path:
    input_rgb = cv2.cvtColor(input_img, cv2.COLOR_BGR2RGB)
    dataset_rgb = cv2.cvtColor(best_dataset_img, cv2.COLOR_BGR2RGB)

    # Tampilkan input dan gambar paling mirip
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.imshow(input_rgb)
    plt.title("Gambar Input")
    plt.axis('off')

    plt.subplot(1, 2, 2)
    plt.imshow(dataset_rgb)
    plt.title(f"Gambar Paling Mirip\nKelas: {most_similar_label.upper()}")
    plt.axis('off')
    plt.tight_layout()
    plt.show()

    print(f"\n✅ Prediksi jenis mobil: {most_similar_label.upper()}")
    print(f"🔍 Jumlah fitur yang cocok: {max_matches}")
    print(f"📄 Lokasi gambar mirip: {most_similar_path}")
else:
    print("❌ Tidak ditemukan gambar yang mirip.")
#Ditampilkan pula informasi prediksi kelas (label), jumlah fitur yang cocok, dan lokasi file yang mirip.
