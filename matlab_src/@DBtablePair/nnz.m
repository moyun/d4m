function s = nnz(T)
%NNZ returns number of nonzero elements in DB table.
%   N = NNZ(T) returns te nnz for DBtablePair T

   DB = struct(T.DB);
   table1 = T.name1;
   table2 = T.name2;
  if strcmp(DB.type,'BigTableLike') || strcmp(DB.type,'Accumulo')
     ops = DBaddJavaOps('edu.mit.ll.d4m.db.cloud.D4mDbTableOperations',DB.instanceName,DB.host,DB.user,DB.pass);
     ops.setCloudType(DB.type);

     % Create an ArrayList
     % Add the table names to the list
     if exist('OCTAVE_VERSION','builtin')
       tablenameList = java_new('java.util.ArrayList');
     else
       tablenameList = javaObject('java.util.ArrayList');
     end
     tablenameList.add(table1);
     tablenameList.add(table2);
     s = ops.getNumberOfEntries(tablenameList);
  end
  if exist('OCTAVE_VERSION','builtin')
    s = s.toString();
    s = str2num(s);
  end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D4M: Dynamic Distributed Dimensional Data Model
% Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
% Software Engineer: Dr. Jeremy Kepner (kepner@ll.mit.edu)
% MIT Lincoln Laboratory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) <2010> Massachusetts Institute of Technology
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
