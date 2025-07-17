% ROTASI DAN TRANSLASI%
% game dan virtual reality%

pkg load image; % pastikan paket image terpasang

% --- Setup axis ---
figure(1); clf;
axis equal;
axis([-10 10 -10 10]);
hold on;
grid on;
title('Objek Bertekstur dengan Transformasi Geometrik (Game/VR)');

% --- Load texture image ---
texture = imread('polakayu.jpg'); % ganti dengan file gambar tekstur

% --- Definisi bentuk objek segiempat (koordinat) ---
quad = [ -1  1  1 -1;
          -1 -1 1  1 ];  % (x, y) 4 titik

% --- Fungsi Rotasi 2D ---
function pts_rot = rotate(points, angle_deg)
    theta = deg2rad(angle_deg);
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    pts_rot = R * points;
endfunction

% --- Fungsi Translasi 2D ---  untuk translasi 2D
function pts_trans = translate(points, tx, ty)
    T = [tx; ty];
    pts_trans = points + T;
endfunction

angle = 0;
pos_x = 0;
pos_y = 0;

% --- Animasi ---  pola perpindahan dan rotasi
for t = 1:150
    angle = angle + 2;           % rotasi 2° per frame
    pos_x = 5 * sin(t/20);       % gerak sinusoidal horizontal
    pos_y = 4 * cos(t/25);       % gerak kosinusoidal vertikal

    % Transformasi objek
    quad_rot = rotate(quad, angle);
    quad_tr = translate(quad_rot, pos_x, pos_y);

    % Clear figure
    clf; hold on; axis equal; grid on;
    axis([-10 10 -10 10]);
    title('Objek Bertekstur dengan Transformasi Geometrik (Game/VR)');

    % --- Render tekstur pada objek ---
    % Buat polygon (patch) dan gunakan citra sebagai texture mapping
    % Note: Octave tidak mendukung texture mapping native,
    % jadi kita simulasikan dengan fungsi image di lokasi objek

    % Hitung bounding box objek untuk menampilkan gambar tekstur
    min_x = min(quad_tr(1,:));
    max_x = max(quad_tr(1,:));
    min_y = min(quad_tr(2,:));
    max_y = max(quad_tr(2,:));

    % Tampilkan tekstur di area bounding box objek
    imagesc([min_x max_x], [min_y max_y], texture);
    set(gca,'YDir','normal'); % agar orientasi y benar

    % Gambar line objek
    %plot([quad_tr(1,:) quad_tr(1,1)], [quad_tr(2,:) quad_tr(2,1)], 'k-', 'LineWidth', 2);

    pause(0.03);
end

