close all;
clear;
clc;

% 1. sloupec - Rychlost
% 2. sloupec - Uplinulý čas
% 3. sloupec - Vzdálenost
% 7. sloupec - Proud baterie
% 8. sloupec - Napětí baterie
% 12. sloupec - Výkon z/do vysokonapěťového akumulátoru
% 20. sloupec - Příkon elektrického pohonu
% 21. sloupec - Teplota elektrického pohonu
% 22. sloupec - Mechanický výkon elektrického pohonu
% 23. sloupec - Kroutící moment elektrického pohonu [Nm]
% 24. sloupec - Otáčky motoru, skutečná hodnota
% 25. sloupec - Elekrický výkon elektrického pohonu, výstup z měniče

%% -------------------------- Přirazení hodnot ----------------------------
data = readmatrix("Data_7.csv");

Speed = data(:,1);
Distance = data(:,3) / 1000;

Battery_Current = data(:,7);
Battery_Voltage = data(:,8);
Battery_Power = data(:,12);

Engine_Power_IN = data(:,20);
Engine_Temperature = data(:,21);
Engine_Mech_Power = data(:,22);
Engine_Torque = data(:,23);
Engine_RPM = data(:,24);
Engine_Power = data(:,25);

%% -------------------------- Vykreslení grafů ----------------------------
% Rychlost
Max_Speed = max(Speed);
[max_hodnota, index_max] = max(Speed); % najde maximum a jeho index
x_max = Distance(index_max); % odpovídající hodnota na ose x

figure("Name","Rychlost");
plot(Distance, Speed);
hold on;
plot(x_max, max_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_max, max_hodnota + 10, sprintf(' Max = %.0f km/h', max_hodnota), 'Color', 'r') % popisek
title("Rychlost");
xlabel("Vzdálenost [km]");
ylabel("Rychlost [km/h]");
grid on;


% Proud Baterie
Max_Battery_Current = max(Battery_Current);
Mix_Battery_Current = abs(min(Battery_Current));
[max_hodnota, index_max] = max(Battery_Current); % najde maximum a jeho index
x_max = Distance(index_max); % odpovídající hodnota na ose x
[min_hodnota, index_min] = min(Battery_Current); % najde maximum a jeho index
x_min = Distance(index_min); % odpovídající hodnota na ose x

figure("Name","Proud Baterie");
plot(Distance, Battery_Current);
hold on
plot(x_max, max_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_max, max_hodnota + 10, sprintf(' Max = %.1f A', max_hodnota), 'Color', 'r') % popisek
plot(x_min, min_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_min, min_hodnota + 10, sprintf(' Max = %.1f A', abs(min_hodnota)), 'Color', 'r') % popisek
yline(0, "-r","LineWidth", 1.5,"DisplayName","Dělící čára")
title("Proud Baterie");
xlabel("Vzdálenost [km]");
ylabel("Proud [A]");
grid on;


% Napětí Baterie
Max_Battery_Voltage = max(Battery_Voltage);
[max_hodnota, index_max] = max(Battery_Voltage); % najde maximum a jeho index
x_max = Distance(index_max); % odpovídající hodnota na ose x

figure("Name","Napětí Baterie");
plot(Distance, Battery_Voltage);
hold on
plot(x_max, max_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_max, max_hodnota + 10, sprintf(' Max = %.1f V', max_hodnota), 'Color', 'r') % popisek
plot(Distance(end), Battery_Voltage(end),'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r')
text(Distance(end) - 3.5, Battery_Voltage(end) + 15, sprintf(' Max = %.1f V', Battery_Voltage(end)), 'Color', 'r') % popisek
title("Napětí Baterie");
xlabel("Vzdálenost [km]");
ylabel("Napětí [V]");
grid on;


% Otáčky motoru
Max_Engine_RPM = max(Engine_RPM);
[max_hodnota, index_max] = max(Engine_RPM); % najde maximum a jeho index
x_max = Distance(index_max); % odpovídající hodnota na ose x

figure("Name","Otáčky motoru");
plot(Distance, Engine_RPM);
hold on
plot(x_max, max_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_max, max_hodnota + 10, sprintf(' Max = %.0f RPM', max_hodnota), 'Color', 'r') % popisek
title("Otáčky motoru");
xlabel("Vzdálenost [km]");
ylabel("Otáčky [RPM]");
grid on;


% Kroutící moment elektrického pohonu
Max_Engine_Torque = max(Engine_Torque);
Min_Engine_Torque = abs(min(Engine_Torque));
[max_hodnota, index_max] = max(Engine_Torque); % najde maximum a jeho index
x_max = Distance(index_max); % odpovídající hodnota na ose x
[min_hodnota, index_min] = min(Engine_Torque); % najde maximum a jeho index
x_min = Distance(index_min); % odpovídající hodnota na ose x

figure("Name","Kroutící moment motoru");
plot(Distance, Engine_Torque);
hold on;
plot(x_max, max_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_max, max_hodnota - 10, sprintf(' Max = %.1f N/m', max_hodnota), 'Color', 'r') % popisek
plot(x_min, min_hodnota, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r') % červený bod
text(x_min, min_hodnota + 10, sprintf(' Max = %.1f N/m', abs(min_hodnota)), 'Color', 'r') % popisek
yline(0, "-r","LineWidth", 1.5,"DisplayName","Dělící čára")
title("Kroutící moment elektrického pohonu");
xlabel("Vzdálenost [km]");
ylabel("Kroutící moment [N/m]");
grid on;


% Výpočet účinnosti 
Avg_Engine_Power = median(abs(Engine_Power));
Avg_Engine_Power_IN = median(abs(Engine_Power_IN));
Engine_Eff = (Avg_Engine_Power/Avg_Engine_Power_IN)*100;


% Výkon motoru
Max_Engine_Power = max(Engine_Power);
[max_hodnota_1, index_max_1] = max(Engine_Power); % najde maximum a jeho index
x_max_1 = Distance(index_max_1); % odpovídající hodnota na ose x
[min_hodnota_1, index_min_1] = min(Engine_Power); % najde maximum a jeho index
x_min_1 = Distance(index_min_1); % odpovídající hodnota na ose x


% Příkon motoru
Max_Engine_Power_IN = max(Engine_Power_IN);
[max_hodnota_2, index_max_2] = max(Engine_Power_IN); % najde maximum a jeho index
x_max_2 = Distance(index_max_2); % odpovídající hodnota na ose x
[min_hodnota_2, index_min_2] = min(Engine_Power_IN); % najde maximum a jeho index
x_min_2 = Distance(index_min_2); % odpovídající hodnota na ose x

figure("Name","Příkon/Výkon elektrického pohonu");
plot(Distance,Engine_Power_IN,"LineWidth", 1.5,"Color","m","DisplayName","Příkon");
hold on;
plot(Distance,Engine_Power,"LineWidth", 1.5,"Color","c","DisplayName","Výkon");
yline(0, "-r","LineWidth", 1.5,"DisplayName","Dělící čára")

plot(x_max_1, max_hodnota_1, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r',"DisplayName","Maximální příkon") % červený bod
text(x_max_1, max_hodnota_1 + 0, sprintf(' Max = %.1f kW', max_hodnota_1), 'Color', 'r') % popisek
plot(x_min_1, min_hodnota_1, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r', "DisplayName","Max. příkon rekuperace") % červený bod
text(x_min_1, min_hodnota_1 - 6, sprintf(' Max = %.1f kW', abs(min_hodnota_1)), 'Color', 'r') % popisek

plot(x_max_2, max_hodnota_2, 'go', 'MarkerSize', 4, 'MarkerFaceColor', 'g',"DisplayName","Maximální výkon") % červený bod
text(x_max_2, max_hodnota_2 + 7, sprintf(' Max = %.1f kW', max_hodnota_2), 'Color', 'r') % popisek
plot(x_min_2, min_hodnota_2, 'go', 'MarkerSize', 4, 'MarkerFaceColor', 'g',"DisplayName","Max. výkon rekuperace") % červený bod
text(x_min_2, min_hodnota_2 - 10, sprintf(' Max = %.1f kW', abs(min_hodnota_2)), 'Color', 'r') % popisek

title("Příkon/Výkon elektrického pohonu");
xlabel("Vzdálenost [km]");
ylabel("Příkon/Výkon [kW]");
legend;
grid on;

%% -------------------------- Výpisy hodnot -------------------------------
fprintf('Maximální dosažená rychlost: %.2f km/h\n', Max_Speed);
fprintf('Maximální dosažený proud baterie: %.2f A\n', Max_Battery_Current);
fprintf('Maximální dosažená rekuperace baterie: %.2f A\n', Mix_Battery_Current);
fprintf('Maximální napětí baterie: %.2f V\n', Max_Battery_Voltage);

fprintf('Maximální dosažený kroutící moment motoru: %.2f N/m\n', Max_Engine_Torque);
fprintf('Maximální dosažený kroutící moment motoru při rekuperaci: %.2f N/m\n', Min_Engine_Torque);
fprintf('Maximální dosažené otáčky motoru: %.0f RPM\n', Max_Engine_RPM);
fprintf('Nejvyšší dosažený výkon motoru: %.2f kW\n', Max_Engine_Power);
fprintf('Nejvyšší dosažený příkon motoru: %.2f kW\n', Max_Engine_Power_IN);
fprintf('Účinnost elektrického pohonu: %.2f %%\n', Engine_Eff);