classdef camnodepath <handle & camplot
    % cam path defined as object with path level methods.
    
    properties
        
    nodes
    
    end
    
    
    methods
        
        function obj = camnodepath(data)
            
            if nargin > 0
                
                    obj.nodes = data;
                    
                
            end
            
            
        end
        
        
               
        function cluster = kmeans(obj, N)
            %find kmeans clusters
            
            ivo = obj.nodes(:,1);
            evc = obj.nodes(:,2);
            
            [idx, out] = kmeans([ivo, evc], N);
            
            cluster(max(idx)).points = [];
            
            for i = 1 : max(idx)
                
                cluster(i).points = obj.nodes(idx==i,:);
                cluster(i).centres = out(i, :);
            end

        end
        
       
        
        function cluster = farcluster(obj, track, N)
            
            ivo = obj.nodes(:,1);
            evc = obj.nodes(:,2);
            
            ivo_track = track.nodes(:,1);
            evc_track = track.nodes(:,2);
            

            mintrackdist = arrayfun(@(ivo, evc) min(sqrt((ivo - ivo_track).^2 ...  %point distance to track
                + (evc - evc_track).^2)), ivo, evc, 'UniformOutput', false);
            
            mintrackdist = cell2mat(mintrackdist);
            
            k = floor(length(mintrackdist) / N);
            
            cluster(N).points = [];
           
            for i = 1 : N
                
                [~, idx] = maxk(mintrackdist, k);
                cluster(i).points = obj.nodes(idx,:);
                cluster(i).centres(1, 1) = mean(obj.nodes(idx,1));
                cluster(i).centres(1, 2) = mean(obj.nodes(idx,2));
                
                mintrackdist(idx, :) = NaN;
                
            end
            
        end
       
    end
end

