pkg load image  % Pastikan paket image sudah aktif

% Baca gambar
img = imread('bangunan.jpg');

% Parameter transformasi
theta = 30; % rotasi dalam derajat
scale = 1.2; % skala
tx = 50; % translasi x
ty = 30; % translasi y

% Konversi rotasi ke radian
theta_rad = deg2rad(theta);

% Matriks affine (2x3)
T = [ scale*cos(theta_rad), -scale*sin(theta_rad), 0;
      scale*sin(theta_rad),  scale*cos(theta_rad), 0];

% Tambahkan translasi
T(:,3) = [tx; ty];

% Buat transformasi affine
tform = maketform('affine', T');

% Terapkan transformasi pada gambar
img_transformed = imtransform(img, tform);

% Tampilkan gambar asli dan hasil transformasi dalam satu figur
figure;
subplot(1,2,1);
imshow(img);
title('Gambar Asli');

subplot(1,2,2);
imshow(img_transformed);
title('Hasil Transformasi Affine');

