normal_data_path = "./heartbeat/normal/set_b";
murmur_data_path= "./heartbeat/not_normal/murmur"
extrastole_data_path= "./heartbeat/not_normal/extrastole"

audio_length = 12000; %beat rate : 4000, 4000 * 3sec = 12,000
dataIndex = 1;
data = 0;
rate = 0;

%=============Normal Data Save Start=================


%Set_b의 3초 이하 normal 데이터 : 115개

normal_dataset = zeros(audio_length, 115); 
lists = dir(normal_data_path);
n = length(lists);

for k = 3:n
  file_name = strcat(normal_data_path,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, audio_length]);
    normal_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 3s'
  end_try_catch
endfor


save('./dataset/normal_heartbeat_dataset.mat', 'normal_dataset')

%=============Normal Data Save Done=================


%=============Not Normal Data Save Start=================

%3초 이하 데이터 : 55개

lists = dir(murmur_data_path);
n = length(lists);
murmur_dataset = zeros(audio_length, 55);
dataIndex = 1;

for k = 3:n
  file_name = strcat(murmur_data_path,'/',lists(k).name);
  try
    [murmur_data, rate] = audioread(file_name, [1, audio_length]);
    murmur_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 3s'
  end_try_catch
endfor

save('./dataset/murmur_heartbeat_dataset.mat', 'murmur_dataset')

%3초 이하 데이타 : 37개
lists = dir(extrastole_data_path);
n = length(lists);
extrastole_dataset = zeros(audio_length, 37);
dataIndex = 1

for k = 3:n
  file_name = strcat(extrastole_data_path,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, audio_length]);
    extrastole_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 3s'
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
