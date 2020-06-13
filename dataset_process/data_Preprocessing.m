clc;
clear all;

normal_data_path_a = "./heartbeat/normal/set_a";
normal_data_path_b = "./heartbeat/normal/set_b";

murmur_data_path_a = "./heartbeat/not_normal/murmur/set_a"
murmur_data_path_b = "./heartbeat/not_normal/murmur/set_b"

extrastole_data_path_a = "./heartbeat/not_normal/extrastole/set_a"
extrastole_data_path_b = "./heartbeat/not_normal/extrastole/set_b"

audio_length = 12000; %beat rate : 4000, 4000 * 3sec = 12,000
dataIndex = 1;
data = 0;
rate = 0;

%=============Normal Data Save Start=================

normal_dataset = zeros(12000, 231);
%set_b normal : 200개
lists = dir(normal_data_path_b);
n = length(lists);

for k = 3:n
  file_name = strcat(normal_data_path_b,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, audio_length]);
    normal_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  catch
    [data, rate] = audioread(file_name);
    data(size(data,1)+1:12000,1) = 0;
    normal_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  end_try_catch
endfor

%set_a normal : 31개
lists = dir(normal_data_path_a);
n = length(lists);

for k = 3:n
  file_name = strcat(normal_data_path_a,'/',lists(k).name);
  [data, rate] = audioread(file_name);
  transf_data = transformBitrate(data);
    
  try  
    normal_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  catch
    transf_data(size(transf_data,1)+1:12000,1) = 0;
    normal_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  end_try_catch
endfor

save('./dataset/normal_heartbeat_dataset.mat', 'normal_dataset')

%=============Normal Data Save Done=================


%=============Not Normal Data Save Start=================

lists = dir(murmur_data_path_b);
n = length(lists);
murmur_dataset = zeros(audio_length, 100);
dataIndex = 1;

for k = 3:n
  file_name = strcat(murmur_data_path_b,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, audio_length]);
    murmur_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    [data, rate] = audioread(file_name);
    data(size(data,1)+1:12000,1) = 0;
    murmur_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  end_try_catch
endfor

lists = dir(murmur_data_path_a);
n = length(lists);

for k = 3:n
  file_name = strcat(murmur_data_path_a,'/',lists(k).name);
  [data, rate] = audioread(file_name);
  transf_data = transformBitrate(data);
    
  try  
    murmur_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  catch
    transf_data(size(transf_data,1)+1:12000,1) = 0;
    murmur_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  end_try_catch
endfor


save('./dataset/murmur_heartbeat_dataset.mat', 'murmur_dataset')



lists = dir(extrastole_data_path_b);
n = length(lists);
extrastole_dataset = zeros(audio_length, 65);
dataIndex = 1

for k = 3:n
  file_name = strcat(extrastole_data_path_b,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, audio_length]);
    extrastole_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    [data, rate] = audioread(file_name);
    data(size(data,1)+1:12000,1) = 0;
    extrastole_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  end_try_catch
endfor

lists = dir(extrastole_data_path_a);
n = length(lists);

for k = 3:n
  file_name = strcat(extrastole_data_path_a,'/',lists(k).name);
  [data, rate] = audioread(file_name);
  transf_data = transformBitrate(data);
    
  try  
    extrastole_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  catch
    transf_data(size(transf_data,1)+1:12000,1) = 0;
    extrastole_dataset(:,dataIndex) = transf_data(1:12000, 1);
    dataIndex = dataIndex + 1;
  end_try_catch
endfor
save('./dataset/extrastole_heartbeat_dataset.mat', 'extrastole_dataset')

%=============Not Normal Data Save Done=================






% 심음 데이터
%figure;
%plot(1:length(data), data);
%grid on;
%legend('wav file ');
%xlabel('rate');
%ylabel('wav data');
