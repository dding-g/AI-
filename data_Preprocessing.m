normal_data_path_a = "./heartbeat/normal/set_a";
normal_data_path_b = "./heartbeat/normal/set_b";
murmur_data_path= "./heartbeat/not_normal/murmur"
extrastole_data_path= "./heartbeat/not_normal/extrastole"

lists = dir(normal_data_path_a);
n = length(lists);

%=============Normal Data Save Start=================


%Set_b의 5초 이하 normal 데이터 : 192개
%Set_a의 5초 이하 normal 데이터 : 33개
normal_dataset = zeros(5000, 223); 
dataIndex = 1;
data = 0;
rate = 0;

for k = 3:n
  file_name = strcat(normal_data_path_a,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, 5000]);
    normal_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 5s'
    continue;
  end_try_catch
endfor

lists = dir(normal_data_path_b);
n = length(lists);
for k = 3:n
  file_name = strcat(normal_data_path_b,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, 5000]);
    normal_dataset(:,dataIndex) = data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 5s'
  end_try_catch
endfor


save('normal_heartbeat_dataset.mat', 'normal_dataset')

%=============Normal Data Save Done=================


%=============Not Normal Data Save Start=================

%총 데이터 : 68개
%활용 데이터 : 
lists = dir(murmur_data_path);
n = length(lists);
murmur_dataset = zeros(5000, n);
dataIndex = 1;

for k = 3:n
  file_name = strcat(murmur_data_path,'/',lists(k).name);
  try
    [murmur_data, rate] = audioread(file_name, [1, 5000]);
    murmur_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 5s'
  end_try_catch
endfor

save('murmur_heartbeat_dataset.mat', 'murmur_dataset')


lists = dir(extrastole_data_path);
n = length(lists);
extrastole_dataset = zeros(5000, n);
dataIndex = 1

for k = 3:n
  file_name = strcat(extrastole_data_path,'/',lists(k).name);
  try
    [data, rate] = audioread(file_name, [1, 5000]);
    extrastole_dataset(:,dataIndex)=data;
    dataIndex = dataIndex + 1;
  catch
    'Data length is under 5s'
  end_try_catch
endfor

save('extrastole_heartbeat_dataset.mat', 'extrastole_dataset')

%=============Not Normal Data Save Done=================






% 심음 데이터
%figure;
%plot(1:length(data), data);
%grid on;
%legend('wav file ');
%xlabel('rate');
%ylabel('wav data');
