pkg load image

% --- Baca dan konversi gambar ---
img = imread('wajah.jpg');
gray = im2double(rgb2gray(img));  % Gunakan grayscale untuk demo

% --- Ukuran gambar ---
[rows, cols] = size(gray);
cx = cols / 2;  cy = rows / 2;     % Titik tengah
max_radius = min(cx, cy);

% --- Buat grid koordinat (X, Y) ---
[x, y] = meshgrid(1:cols, 1:rows);
dx = x - cx;
dy = y - cy;
r = sqrt(dx.^2 + dy.^2);
theta = atan2(dy, dx);

% --- Parameter twirl ---
twirl_strength = 4;  % Sesuaikan efek

% --- Ubah koordinat sudut berdasarkan jarak dari pusat (twirl) ---
theta_twirl = theta + (twirl_strength * (max_radius - r) ./ max_radius);
theta_twirl(r > max_radius) = theta(r > max_radius);  % Di luar jangkauan, tetap

% --- Konversi kembali ke koordinat kartesian ---
x_twirl = cx + r .* cos(theta_twirl);
y_twirl = cy + r .* sin(theta_twirl);

% --- Interpolasi piksel hasil twirl ---
twirled = interp2(x, y, gray, x_twirl, y_twirl, 'linear', 0);

% --- a. Tampilkan perbandingan ---
figure;
subplot(1,2,1); imshow(gray); title('Asli');
subplot(1,2,2); imshow(twirled); title('Efek Twirl');

