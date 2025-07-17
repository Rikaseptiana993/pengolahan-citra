pkg load image  % Pastikan Image package aktif

% Baca dan ubah ke grayscale
img = imread('wajah.jpg');         % Ganti dengan nama file kamu
gray = rgb2gray(img);              % Ubah ke grayscale

% Ekualisasi histogram
equalized = histeq(gray);

% Tampilkan semua dalam satu figure (2x2 layout)
figure;

% Citra sebelum
subplot(2,2,1);
imshow(gray);
title('Citra Sebelum Ekualisasi');

% Histogram sebelum
subplot(2,2,2);
imhist(gray);
title('Histogram Sebelum');

% Citra setelah
subplot(2,2,3);
imshow(equalized);
title('Citra Setelah Ekualisasi');

% Histogram setelah
subplot(2,2,4);
imhist(equalized);
title('Histogram Setelah');

