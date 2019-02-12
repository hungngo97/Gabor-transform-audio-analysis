%TODO: do the same thing for the recording
% Compare the difference between piano and recording
% Clear our overtones
close all; clear all; clc;
tr_piano=16; % record time in seconds
y_piano=audioread('music1.wav'); Fs_piano=length(y_piano)/tr_piano;
y_piano = y_piano';
% plot((1:length(y_piano))/Fs_piano,y_piano);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (piano)'); drawnow
% p8 = audioplayer(y_piano,Fs_piano); playblocking(p8);

%%
%TODO: Ask how to clear overtones????
%clearing overtone
central_frequency = [];
prevFreq = y_piano(1);
index = 1;
%%
%FFT
L = tr_piano;
n = length(y_piano); %might need to change this
t2=linspace(0,L,n+1); t=t2(1:n);
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);% ks: # of cycles in 16 sec
hz_piano_frequency = ks / (2 * pi); % of cycles in 1 sec = hertz
%To create picture to see an overview of frequencies in the piano song
% yt_piano = fft(y_piano);
% figure(4)
% plot(ks,abs(fftshift(yt_piano))/max(abs(yt_piano)),'k');
%%
figure(1)
Sgt_spec=[];
tslide = 0:0.58:tr_piano
frequencies_in_time = [];
for j=1:length(tslide)
    %TODO: can change the filter width later 
    %TODO: can try other filters like in part 1
    g=exp(-20*(t-tslide(j)).^2); % Gabor
    Sg=g.*y_piano; Sgt=fft(Sg);
    max_frequency = max(abs(fftshift(Sgt)));
    a = abs(fftshift(Sgt));
    max_index = find(abs(fftshift(Sgt)) == max_frequency);
    piano_frequency_at_current_time = hz_piano_frequency(max_index);
    frequencies_in_time = [frequencies_in_time; piano_frequency_at_current_time];
    Sgt_spec=[Sgt_spec; abs(fftshift(Sgt))];
    subplot(3,1,1), plot(t, y_piano,'k',t,g,'r')
    subplot(3,1,2), plot(t,Sg,'k')
    subplot(3,1,3), plot(hz_piano_frequency,abs(fftshift(Sgt))/max(abs(Sgt)))
    axis([-500 500 0 1]);
    drawnow
    pause(0.1)
    
    %TODO: use this picture to compare the picture when frequencies is in
    %frequencies unit vs  hz unit
%     subplot(3,1,1), plot(t, y_piano,'k',t,g,'r')
%     subplot(3,1,2), plot(t,Sg,'k')
%     subplot(3,1,3), plot(ks,abs(fftshift(Sgt))/max(abs(Sgt)))
%     axis([-1000 1000 0 1]);
%     drawnow
%     pause(0.1)
end

%%
%Spectrogram
figure(2);
pcolor(tslide,hz_piano_frequency,Sgt_spec.'), shading interp
axis([0 16 -500 500]);
set(gca,'Fontsize',[14])
colormap(hot)
% figure(2);
% pcolor(tslide,ks,Sgt_spec.'), shading interp
% set(gca,'Fontsize',[14])
% colormap(hot)
%%
% figure(3);
%spectrogram(y_piano, Fs_piano);

%%
figure(4);
scatter(1:length(tslide), frequencies_in_time(:, 2));
%Piano sheet

%%
tr_rec=14; % record time in seconds
y_rec=audioread('music2.wav'); Fs_rec=length(y_rec)/tr_rec;
% figure(1)
% plot((1:length(y_rec))/Fs_rec,y_rec);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (recorder)');
% p8 = audioplayer(y_rec,Fs_rec); playblocking(p8);
%FFT
y_rec = y_rec';
L = tr_rec;
n = length(y_rec); %might need to change this
t2=linspace(0,L,n+1); t=t2(1:n);
k=(2*pi/L)*[0:n/2-1 -n/2:-1]; ks=fftshift(k);% ks: # of cycles in 16 sec
hz_rec_frequency = ks / ( 2 * pi); % of cycles in 1 sec = hertz

figure(5)
Sgt_spec=[];
tslide = 0:0.55:tr_rec
frequencies_in_time = [];
for j=1:length(tslide)
    %TODO: can change the filter width later 
    %TODO: can try other filters like in part 1
    g=exp(-20*(t-tslide(j)).^2); % Gabor
    Sg=g.*y_rec; Sgt=fft(Sg);
    max_frequency = max(abs(fftshift(Sgt)));
    a = abs(fftshift(Sgt));
    max_index = find(abs(fftshift(Sgt)) == max_frequency);
    rec_frequency_at_current_time = hz_rec_frequency(max_index);
    frequencies_in_time = [frequencies_in_time; rec_frequency_at_current_time];
    Sgt_spec=[Sgt_spec; abs(fftshift(Sgt))];
    subplot(3,1,1), plot(t, y_rec,'k',t,g,'r')
    subplot(3,1,2), plot(t,Sg,'k')
    subplot(3,1,3), plot(hz_rec_frequency,abs(fftshift(Sgt))/max(abs(Sgt)))
    axis([-500 500 0 1]);
    drawnow
    pause(0.1)
    
    %TODO: use this picture to compare the picture when frequencies is in
    %frequencies unit vs  hz unit
%     subplot(3,1,1), plot(t, y_rec,'k',t,g,'r')
%     subplot(3,1,2), plot(t,Sg,'k')
%     subplot(3,1,3), plot(ks,abs(fftshift(Sgt))/max(abs(Sgt)))
%     axis([-5000 5000 0 1]);
%     drawnow
%     pause(0.1)
end

%%
%Spectrogram
figure(6);
pcolor(tslide,hz_rec_frequency,Sgt_spec.'), shading interp
axis([0 14 -1000 1000]);
set(gca, 'Fontsize',[14]);
colormap(hot)
% figure(2);
% pcolor(tslide,ks,Sgt_spec.'), shading interp
% set(gca,'Fontsize',[14])
% colormap(hot)

%%
figure(7);
scatter(1:length(tslide), frequencies_in_time(:, 2));
%Piano sheet


