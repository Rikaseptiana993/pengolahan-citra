%TUGAS PRAKTIKUM 1%

%Membaca Citra %
Img = imread('anjing.jpg');

%Menampilkan Citra %
subplot(1,3,1), imshow(Img), title('Citra Asli');

%Menampilkan Ukuran Citra %
Ukuran = size(Img);

%Mengkonversi Citra Warna ke Grayscale %
RGB = imread('upinipin.jpg');
Abu = rgb2gray(RGB);
subplot(1,3,2), imshow(Abu), title('Citra Grayscale');

%Mengkonversi Citra Grayscale ke Biner %
Img = imread('daun.jpg');
[tinggi, lebar] = size(Img);
ambang = 210; % Nilai ini bisa diubah-ubah
biner = zeros(tinggi, lebar);
for baris=1 : tinggi
for kolom=1 : lebar
if Img(baris, kolom) >= ambang
Biner(baris, kolom) = 0;
else
Biner(baris, kolom) = 1;
end
end
end
subplot(1,3,3), imshow(Biner), title('Citra Biner');

%Menyimpan Citra %
RGB = imread('upinipin.jpg');
Abu = rgb2gray(RGB);
imwrite(Abu, 'gray_upinipin.jpg')
