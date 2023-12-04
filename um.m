% Especificações do filtro
fs = 20000;  % Frequência de amostragem (20 kHz)
f_corte = 1000;  % Frequência de corte (1 kHz)
atenua = 50;  % Atenuação mínima na banda de rejeição (50 dB)

% Normalizando as frequências de corte para a faixa [0, 1]
normal_fc = f_corte / (fs / 2);

% Ordem do filtro (comprimento do filtro - 1)
ordem = 500;

% Filtro FIR
b = fir1(ordem, normal_fc, "high", kaiser(ordem+1, 0.1102 * atenua));

% Plot da resposta em frequência do filtro
freqz(b, 1, 1024, fs);
