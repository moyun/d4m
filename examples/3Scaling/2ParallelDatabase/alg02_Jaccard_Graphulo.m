function alg02_Jaccard_Graphulo(DB, G, tname, TNadjUU, TNadjUUDeg, TNadjJaccard, NUMTAB, infoFunc)

% experiment data format
% ROW: DH_jaccard__DH_pg10_20160331__nt1|20160403-225353
timeStartStr = datestr(now,'yyyymmdd-HHMMSS');

LSDB = ls(DB);
if StrSearch(LSDB,[TNadjUU ' ']) < 1 || StrSearch(LSDB,[TNadjUUDeg ' ']) < 1
    error(['Please create ' TNadjUU ' and ' TNadjUUDeg]);
end
TadjUU = DB(TNadjUU); 
%TadjUUDeg = DB(TNadjUUDeg);
% Ensure result table is fresh
if StrSearch(LSDB,[TNadjJaccard ' ']) >= 1
    TadjJaccard = DB(TNadjJaccard);
    delete(TadjJaccard);
end
% Pre-create result table
TadjJaccard = DB(TNadjJaccard);

tic;
numEntries = nnz(TadjUU);
splitPoints = G.findEvenSplits(TNadjUU, NUMTAB-1, numEntries / NUMTAB);
putSplits(TadjUU, splitPoints);
G.Compact(TNadjUU); % force new splits
[splitPoints,splitSizes] = getSplits(TadjUU);
splitCompact = toc; fprintf('Split %d & compact time: %f\n',NUMTAB,splitCompact);
pause(2)

tic;
numpp = G.Jaccard(TNadjUU, TNadjUUDeg, TNadjJaccard, [], [], []);
graphuloJaccard = toc; fprintf('Graphulo Jaccard Time: %f\n',graphuloJaccard);


numEntriesRightAfter = nnz(TadjJaccard);
fprintf('numEntriesRightAfter   %d\n', numEntriesRightAfter);
G.Compact(TNadjJaccard);
numEntriesAfterCompact = nnz(TadjJaccard);
fprintf('numEntriesAfterCompact %d\n', numEntriesAfterCompact);

nl = char(10);
% DH_jaccard__DH_pg10_20160331__nt1|20160403-225353
row = ['DH_jaccard__' tname '__nt' num2str(NUMTAB) '|' timeStartStr nl];
Ainfo = Assoc('','','');
Ainfo = Ainfo + Assoc(row,['graphuloJaccard' nl],[num2str(graphuloJaccard) nl]);
%Ainfo = Ainfo + Assoc(row,['correct' nl],[num2str(correct) nl]);
Ainfo = Ainfo + Assoc(row,['numpp' nl],[num2str(numpp) nl]);
if (NUMTAB > 1)
    Ainfo = Ainfo + Assoc(row,['splitPoints' nl],[splitPoints nl]);
    Ainfo = Ainfo + Assoc(row,['splitSizes' nl],[splitSizes nl]);
%     Ainfo = Ainfo + Assoc(row,['splitPointsR' nl],[splitPointsR nl]);
%     Ainfo = Ainfo + Assoc(row,['splitSizesR' nl],[splitSizesR nl]);
end
Ainfo = Ainfo + Assoc(row,['numEntriesRightAfter' nl],[num2str(numEntriesRightAfter) nl]);
Ainfo = Ainfo + Assoc(row,['numEntriesAfterCompact' nl],[num2str(numEntriesAfterCompact) nl]);
Ainfo = Ainfo + Assoc(row,['splitCompact' nl],[num2str(splitCompact) nl]);
Ainfo = Ainfo + Assoc(row,['tname' nl],[tname nl]);
infoFunc(Ainfo);

