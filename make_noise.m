%creates noise matrix

j=1;
if ~isempty(noise.pelletcue)
    for i = 1:length(noise.pelletcue);
        noise_all(j) = noise.pelletcue{i} + 0;
        j = j+1;
    end
end
if ~isempty(noise.infcue)
    for i = 1:length(noise.infcue);
        noise_all(j) = noise.infcue{i} + length_mat(1,1);
        j = j+1;
    end
end
if ~isempty(noise.probepellet)
    for i = 1:length(noise.probepellet);
        noise_all(j) = noise.probepellet{i} + sum(length_mat(1,1:2));
        j = j+1;
    end
end
if ~isempty(noise.probeinf)
    for i = 1:length(noise.probeinf);
        noise_all(j) = noise.probeinf{i} + sum(length_mat(1,1:3));
        j = j+1;
    end
end
if ~isempty(noise.dummy)
    for i = 1:length(noise.dummy);
        noise_all(j) = noise.dummy{i} + sum(length_mat(1,1:4));
        j = j+1;
    end
end
