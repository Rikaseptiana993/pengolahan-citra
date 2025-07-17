pkg load image  % Pastikan package aktif

% --- Baca gambar dan ubah ke grayscale ---
img = imread('wajah.jpg');           % Ganti sesuai nama file kamu
gray = rgb2gray(img);                % Konversi ke grayscale

% --- Terapkan filter median 3x3 ---
median_filtered = medfilt2(gray, [3 3]);

% --- Terapkan filter mean 3x3 ---
mean_kernel = fspecial('average', [3 3]);
mean_filtered = imfilter(gray, mean_kernel);

% --- Tampilkan hasil dalam satu figure ---
figure;

subplot(2,2,1);
imshow(gray);
title('Asli (Noisy)');

subplot(2,2,2);
imshow(median_filtered);
title('Filter Median 3x3');

subplot(2,2,3);
imshow(mean_filtered);
title('Filter Mean 3x3');

subplot(2,2,4);
imshowpair(median_filtered, mean_filtered, 'diff');
title('Selisih Median vs Mean');

