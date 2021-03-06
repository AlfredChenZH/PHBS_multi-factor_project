function structRows = getStructToCleanUpdate(obj)
%GETSTRUCTTOCLEANUPDATE from obj.updateRows to get slice size and make a
%new copy of structure that is used to feed to stock selection process.
%   NOTE: depend on defaultTableNamesToSelect = 'tableNamesToSelect.json';
    
    minimumSliceSize = obj.updateRows;
    
    %add warning
    if isempty(minimumSliceSize)
        warning("the properties updateRows is empty!");
    end
    
    fNs = obj.jsonDecoder(obj.defaultTableNamesToSelect);
    
    % step 1: give values back to structRows
    structRows = struct();
    fN = fieldnames(fNs);
    for count =1: length(fN)
        fN_array = strsplit(fN{count},'_'); %'_'
        % try to fetch data from data struct
        try
            rawFieldData = obj.parseStringToStructPath(obj.rawStruct,strjoin(strsplit(fN{count},'_'),'.')); %'_'
        catch
            error('%s can not be fetched from existing data struct, may be incorrect table name in cleanDataConfig/tableNamesToSelect.json',strjoin(strsplit(fN{count},'_'),'.'));
        end
        
        % get lastest data
        try
            structRows.(fN_array{end}) = rawFieldData(end - minimumSliceSize + 1:end,:);
        catch
            error('%s has fewer records than minimum slice size, please use get method to check required minimum size',fN);
        end
    end
    
    % step 2: check all tables in structRows, if columns size are equal,
    % set selectedStruct to be structRows, otherwise throw error
    fieldTableColSize = [];
    fN = fieldnames(structRows);
    for count = 1:length(fN)
       currentTable = structRows.(fN{count});
       fieldTableColSize = [fieldTableColSize; size(currentTable,2)];
    end
    
    if all(fieldTableColSize == fieldTableColSize(1))
        obj.preSelectedStruct = structRows;
    else
        error 'column size of input data not match, please check!';
    end
end

