% Baca gambar grayscale
img = imread('taman.jpg');
gray = rgb2gray(img); % Jika belum dalam bentuk grayscale

% Fungsi kuantisasi
function qimg = quantize_gray(img, levels)
  step = 256 / levels;
  qimg = floor(double(img) / step) * step;
  qimg = uint8(qimg);
end

% Kuantisasi ke 2, 4, dan 8 tingkat
q2 = quantize_gray(gray, 2);
q4 = quantize_gray(gray, 4);
q8 = quantize_gray(gray, 8);

% Tampilkan semua hasil
figure;
subplot(2,2,1); imshow(gray); title('Asli (256 tingkat)');
subplot(2,2,2); imshow(q2); title('Kuantisasi 2 tingkat');
subplot(2,2,3); imshow(q4); title('Kuantisasi 4 tingkat');
subplot(2,2,4); imshow(q8); title('Kuantisasi 8 tingkat');

