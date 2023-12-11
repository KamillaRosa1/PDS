clc;
pkg load signal

%Gráficos do arquivo WAV:
[sinal, frequencia_amostragem] = audioread('vogais.wav');
soundsc(sinal, frequencia_amostragem);

tempo_total = length(sinal) / frequencia_amostragem;
tempo = linspace(0, tempo_total, length(sinal));
subplot(2, 1, 1);
plot(tempo, sinal);
title('Sinal Original');
xlabel('Tempo (s)');
ylabel('Amplitude');

sinal_fft = fft(sinal);
frequencias = linspace(0, frequencia_amostragem, length(sinal_fft));
subplot(2, 1, 2);
plot(frequencias, abs(sinal_fft));
title('FFT do Sinal');
xlabel('Frequência (Hz)');
ylabel('Magnitude');

pause(0.1); % Pausa para garantir a renderização dos gráficos

%Gerar o inverso:
sinal_invertido = flip(sinal);

arquivo_saida = 'vogais_inv.wav';
audiowrite(arquivo_saida, sinal_invertido, frequencia_amostragem);

fprintf('Tocando o áudio invertido...\n');
soundsc(sinal_invertido, frequencia_amostragem);

%Misturar Som:
duracao = length(sinal) / frequencia_amostragem; % Duração do som igual ao áudio "vogais.wav"
frequencia_do = 261.63;
tempo = linspace(0, duracao, length(sinal));
som_do = sin(2 * pi * frequencia_do * tempo);

sinal_misturado = sinal + som_do';

arquivo_misturado = 'vogais_do.wav';
audiowrite(arquivo_misturado, sinal_misturado, frequencia_amostragem);

fprintf('Tocando o áudio misturado...\n');
soundsc(sinal_misturado, frequencia_amostragem);

%Filtro:
faixa_passa_faixa = [1000, 4000]; % Faixa de frequência para tentar isolar
ordem_filtro_passa_faixa = 100;
filtro_passa_faixa = fir1(ordem_filtro_passa_faixa, faixa_passa_faixa / (frequencia_amostragem / 2), 'bandpass');

sinal_filtrado = filter(filtro_passa_faixa, 1, sinal_misturado);

fprintf('Tocando o áudio filtrado...\n');
soundsc(sinal_filtrado, frequencia_amostragem);
