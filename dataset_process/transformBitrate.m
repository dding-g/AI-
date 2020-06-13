function transf_data = transformBitrate(data)
  %44100 bitrate to 4000 bitrate
  %4000 / 44100 = 0.090703
  transDataInd = 1;
  dataIdx = 1;
  
  for k = 1:size(data,1)/0.090703
    try
      transf_data(transDataInd, 1) = max(data(dataIdx:dataIdx+9,:));
      transDataInd = transDataInd + 1;
      dataIdx = dataIdx + 10;
    catch
      break
    end_try_catch
  end  
  
endfunction
