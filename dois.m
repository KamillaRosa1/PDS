% Carregar o arquivo de áudio
[y, fs] = audioread('minha_voz.wav');

% Tempo total do sinal de áudio
total_t = length(y) / fs;
t_vetor = linspace(0, total_t, length(y));

% Plotar o sinal original
subplot(3, 1, 1);
plot(t_vetor, y);
title('Sinal de Áudio Original');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Realizar a FFT
Y = fft(y);

% Frequências correspondentes
frequencias = linspace(0, fs, length(Y));

% Plotar o espectro de frequência (FFT)
subplot(3, 1, 2);
plot(frequencias, abs(Y));
title('Espectro de Frequência (FFT)');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([0, fs/2]);

% Frequência de corte para o filtro passa-alta
f_corte = 600; % Frequência de corte em Hz

% Normalizando a frequência de corte para a faixa [0, 1]
normal_fc = f_corte / (fs / 2);

% Ordem do filtro IIR
ordem = 4;

% Projeto do filtro IIR passa-alta Butterworth
[b, a] = butter(ordem, normal_fc, 'high');

% Aplicando o filtro ao áudio
y_filtrado = filter(b, a, y);

% Plotar o sinal filtrado
subplot(3, 1, 3);
plot(t_vetor, y_filtrado);
title('Sinal de Áudio Filtrado (Passa-Alta)');
xlabel('Tempo (s)');
ylabel('Amplitude');

% Criar um novo arquivo do sinal filtrado
audiowrite('voz_filtrado.wav', y_filtrado, fs);

% Reproduzindo o áudio original e o áudio filtrado
sound(y, fs);
pause(0.5);
sound(y_filtrado, fs);
