clc
clear all

inputDir = 'data/wheel/cylinder/';
outputDir = 'data/wheel_vtk/cylinder/';
totalFiles = 400;
for i = 1:totalFiles
    filename = sprintf('%sdata_%04d.dat', inputDir, i);
    [verticePosArray, facetsArray, numVertices, numFacets] = extractMeshInfo(filename);
    
    outputFilename = sprintf('%swheel_%04d.vtk', outputDir, i);
    writeVTK(verticePosArray, facetsArray, numVertices, numFacets, outputFilename);
end

function [verticePosArray, facetsArray, numVertices, numFacets] = extractMeshInfo(filename)
extraNumLines = 7;
fid = fopen(filename);

for i = 1:extraNumLines
    tline = fgetl(fid);
end

numVertices = str2num(tline);
verticePosArray = zeros(numVertices, 3);

for ii = 1:numVertices
    % get vertice positions
    tline = fgetl(fid);
    pos = cell2mat(textscan(tline, '%f'));
    verticePosArray(ii,:) = pos';    
end

% skip velocity info of vertices, stop until find character CONNECTIVITY
keyword = ' Connectivity';
while true    
    tline = fgetl(fid);
    if contains(tline, keyword)
        break;
    end
end

numFacets = str2num(tline(length(keyword)+2:end));
facetsArray = zeros(numFacets, 3);
for ii = 1:numFacets
    % get vertice positions
    tline = fgetl(fid);
    triangle = cell2mat(textscan(tline, '%d'));
    facetsArray(ii,:) = triangle';    
end

fclose(fid);
end

function writeVTK(verticePosArray, facetsArray, numVertices, numFacets, filename)
fid = fopen(filename, 'w');
fprintf(fid, "# vtk DataFile Version 2.0\n");
fprintf(fid, "VTK from simulation\n");
fprintf(fid, "ASCII\n\n\n");
fprintf(fid, "DATASET UNSTRUCTURED_GRID\n");
fprintf(fid, "POINTS %d float\n", numVertices);
for ii = 1:numVertices
    fprintf(fid, "%f %f %f\n", verticePosArray(ii,1), verticePosArray(ii,2), verticePosArray(ii,3));
end
fprintf(fid, "\nCELLS %d %d\n", numFacets, numFacets*4);
for ii = 1:numFacets
    fprintf(fid, "3 %d %d %d\n", facetsArray(ii,1), facetsArray(ii,2), facetsArray(ii,3));
end
fprintf(fid, "\n\nCELL_TYPES %d\n", numFacets);
for ii = 1:numFacets
    fprintf(fid, "5\n");
end
fclose(fid);
end