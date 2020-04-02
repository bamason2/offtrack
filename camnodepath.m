classdef camnodepath <handle
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    nodes
    
    
    
    
    end
    
    methods
        
        function obj = camnodepath(data)
            
            if nargin > 0
                
                    obj.nodes = data;
                    
                
            end
            
            
        end
        
        
        function cluster = trackdist(obj, track)

            ivo = obj.nodes(:,1);
            evc = obj.nodes(:,2);
            
            ivo_track = track.nodes(:,1);
            evc_track = track.nodes(:,2);
            
            m = length(ivo);
            N=500;
            
            mintrackdist = arrayfun(@(ivo, evc) min(sqrt((ivo - ivo_track).^2 ...  %point distance to track
                + (evc - evc_track).^2)), ivo, evc, 'UniformOutput', false);
            
            mintrackdist = cell2mat(mintrackdist);
            
            alldist = arrayfun(@(ivo, evc) sqrt((ivo - obj.nodes(:,1)).^2 + (evc - obj.nodes(:,2)).^2), ivo, evc, 'UniformOutput', false);  %interpoint distances
            alldist = reshape(cell2mat(alldist), m, m);
            
            i=1;
            
            while  N < sum(~isnan(mintrackdist))
              
                   [~, idx1] = max(mintrackdist);       %select centriod as point furthest away from any one index
            
                  
                   [~, idx2] = mink(alldist(idx1, :), N + 1);
                   
                   cluster(i).points = obj.nodes(idx2,:);
                   cluster(i).centre = obj.nodes(idx1,:);
                   i=i+1;
                   
                   
                   mintrackdist(idx2) = NaN;
                   
                    
            end

            
        end
        
        
        function obj = nearestx(obj, nodeslocation)
            %returns ranked vector of nearest nodes in list
            
            
            
        end
        
        
    end
end

