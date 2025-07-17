pkg load image  % Pastikan image package aktif

% --- a. Baca gambar dan konversi ke grayscale ---
img = imread('daun.jpg');        % Ganti dengan file kamu
gray = rgb2gray(img);

% --- Terapkan filter smoothing (mean 3x3) sebagai low-pass ---
h = fspecial('average', [3 3]);
blurred = imfilter(gray, h);

% --- Terapkan High-Boost Filtering ---
A = 1.5;   % Faktor penguat
mask = double(gray) - double(blurred);            % Detail layer
highboost = uint8(double(gray) + (A - 1) * mask);  % High-boosted image

% --- b. Tampilkan citra sebelum dan sesudah ---
figure;
subplot(1,2,1); imshow(gray); title('Asli (daun)');
subplot(1,2,2); imshow(highboost); title('Setelah High-Boost Filtering');

