function rowSplitStr = Split(T);
%SPLIT gets splits for a table.

  DB = struct(T.DB);
  if strcmp(DBstruct.type,'BigTableLike') || strcmp(DBstruct.type,'Accumulo')

%    rowSplitStr = DBgetSplit(DB.instanceName, DB.host, T.name, DB.user, DB.pass);

  end


% Need to make stub for Assoc.

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D4M: Dynamic Distributed Dimensional Data Model
% Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
% Software Engineer: Dr. Jeremy Kepner (kepner@ll.mit.edu)
% MIT Lincoln Laboratory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) <2010> Massachusetts Institute of Technology
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

