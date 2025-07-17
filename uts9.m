pkg load image;

% Membaca gambar
img_color = imread('parkiran.jpg');

% Konversi ke grayscale
img_gray = rgb2gray(img_color);

% Konversi ke double
img_gray = im2double(img_gray);

% Tampilkan gambar asli (grayscale)
subplot(1, 2, 1);
imshow(img_gray);
title('Citra Asli (Grayscale)');

% Membuat filter Gaussian
filter_size = 7;   % Ukuran kernel (misalnya 7x7)
sigma = 1.5;       % Nilai sigma

gaussian_filter = fspecial('gaussian', filter_size, sigma);

% Terapkan filter Gaussian
img_filtered = imfilter(img_gray, gaussian_filter, 'replicate');

% Tampilkan gambar hasil filter
subplot(1, 2, 2);
imshow(img_filtered);
title('Setelah Filter Gaussian');
