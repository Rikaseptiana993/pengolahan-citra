pkg load image  % pastikan package image aktif

% 1. Membaca gambar asli berwarna
img = imread('taman.jpg');  % Gantilah dengan nama gambar Anda

% 2. Konversi ke grayscale
gray = rgb2gray(img);

% 3. Konversi ke biner menggunakan threshold otomatis (Otsu)
level = graythresh(gray);
binary = im2bw(gray, level);  % atau imbinarize(gray) jika ada

% 4. Tampilkan semua hasil
figure;
subplot(1,3,1); imshow(img); title('RGB');
subplot(1,3,2); imshow(gray); title('Grayscale');
subplot(1,3,3); imshow(binary); title('Biner');
