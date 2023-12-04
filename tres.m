% Carregando o arquivo de áudio
[y, fs] = audioread('som_com_ruido.wav');

% Normalizando o áudio
y = y / max(abs(y));

% Frequência de corte para remover o som agudo
f_corte = 3000;

% Normalizando a frequência de corte para a faixa [0, 1]
normal_fc = f_corte / (fs / 2);

% Ordem do filtro (comprimento do filtro - 1)
ordem = 200;

% Projeto do filtro FIR passa-baixas
b = fir1(ordem, normal_fc);

% Aplicando o filtro ao áudio
y_filtrado = filter(b, 1, y);

% Reproduzindo o áudio original e o áudio filtrado
sound(y, fs);
pause(0.5);
sound(y_filtrado, fs);
