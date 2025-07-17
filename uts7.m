pkg load image  % Pastikan image package aktif

% --- a. Baca gambar ---
img = imread('papantulis.jpg');
gray = rgb2gray(img);  % Konversi ke grayscale jika perlu

% --- a. Rotasi agar tegak lurus (misal rotasi -30 derajat) dengan interpolasi bilinear ---
rotated = imrotate(gray, -90, 'bilinear');  % Sesuaikan sudut sesuai gambar

% --- b. Perbesar citra (misal 2x) agar teks lebih mudah dibaca ---
scaled = imresize(rotated, 2);  % Skala pembesaran = 2x

% --- Tampilkan hasil ---
figure;
subplot(1,3,1); imshow(gray); title('Asli (Sudut Miring)');
subplot(1,3,2); imshow(rotated); title('Setelah Rotasi (Tegak Lurus)');
subplot(1,3,3); imshow(scaled); title('Setelah Perbesaran');

