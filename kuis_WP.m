opts = detectImportOptions('Real estate valuation data set.xlsx'); %untuk mendeteksi data
opts.SelectedVariableNames = (3:5); %untuk mengambil data kolom 3 sampai 5
data1 = readmatrix('Real estate valuation data set.xlsx',opts); %untuk menyimpan data diatas ke data1

opts = detectImportOptions('Real estate valuation data set.xlsx'); %untuk mendeteksi data
opts.SelectedVariableNames = (8); %untuk mengambil data kolom 8
data2 = readmatrix('Real estate valuation data set.xlsx',opts); %untuk menyimpan data diatas ke data1

data = [data1 data2]; %menyimpan data1 dan data2 sebagai matriks di data
data = data(1:50,:); %dari data diambil 50 paling atas

x = data; % data disimpan ke x
k = [0,0,1,0]; %atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya 
w = [3,5,4,1]; %nilai bobot tiap kriteria

[m n] = size(x); %menentukan besar matriks x kemudian disimpan ke dalam matrik [m x n]
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot 

%melakukan perhitungan vektor(S) per baris (alternatif) for j=1:n, 
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;

for i=1:m,
    S(i) = prod(x(i,:).^w);
end;
%proses perangkingan 
V = S/sum(S);
Vtranspose = V.';
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
x2 = readmatrix('Real estate valuation data set.xlsx',opts);
x2 = x2(1:50,:);
x2 = [x2 Vtranspose];
x2 = sortrows(x2,-2);
x2 = x2(1:5,1);

disp ('Rekomendasikan')
disp (x2)