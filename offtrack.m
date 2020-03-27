classdef offtrack
% Aim: Identify test points for measurement of off track performance.
% 1)	Identify the x furthest points away from camtrack indices
% 2)	Cluster the neighbourhood of points around each centroid x
% 3)	Plot each off track cluster against the camtrack


%changelog
%----------------------------------------------
%24MAR20         BM      Initial specification.
%24MAR20         BM      Constructor and plotscatter method functionlity
%                        added. Track and index points hardcoded.
%27MAR20         BM      Added distance metric. switched column order in
%                        obj.points



    
    
    properties 
        
        points              % all points from dataset defined as matrix with rows as
                            % cartesian coordinates [x, y]
        
        idxpoints =  [      % index points for analysis as matrix with rows as
                            % cartesian coordinates [x, y]
            0-15, 0; 
            0-15, 10;
            0-15, 25;
            0-15, 40;
            -15-15, 50;
            -25-15, 50;
            -35-15, 50;
            -40-15, 37.5;
            -45-15, 25;
            -28.5-15, 25;
            -15-15, 20;
            -5-15, 20;
            -15-15, 0;
            -5-15, 25;
            -26.75-15, 37.5;
            -30-15, 10
            ];
        
        numberpoints        % scalar value representing number points to cluster around centre
        
        track_11 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]';
        
        engine_label = 'Fox TT';
        
    end
        

    properties (Dependent)
    
        centres             %list of point centres and cluster of points around these

            
    end
    
    
    
    methods
        
        function obj = offtrack(inputdata)  
            %constructor method that creates object from data file. idx are
            %the reference index points in the cam space entered as a
            %matrix with rows as tuples representing cartesian x, y
            %coordinates. data is the filename with the data.
            
            % import index points
            %obj.idxpoints = table(idx(:,1), idx(:,2), 'VariableNames', {'ivo', 'evc'});
            


            % import relevant data points
            fields = {'VCT_CAM_ACT_INT', 'VCT_CAM_ACT_EXH'};
            
            data = load(inputdata);
            
            obj.points = table(data.(fields{1}).signals.values, data.(fields{2}).signals.values, 'VariableNames', {fields{1}, fields{2}});
        
        
        end

        
        function idx = getfurthest(obj, points)
           
            if nargin == 1 %compare with each of the obj.points and return index
                
                distances = zeros(height(obj.points), 1);
                
                
                for i = 1 : height(obj.points)
                    
                    points = obj.points{:,:};
                    distances(i) = obj.mindist(points(i,:));
                   
                    
                    
                end
                
            end
            
            
            if nargin == 2 % compare with each of the points specfied and return index
            
                for i = 1 : length(points)
                    
                   distances(i) = mindist(points(i,:));
                    
                    
                end
                
            end
            
        
        
        idx = find(distances == max(distances));
        
        end
        
        
        function dist = mindist(obj, point, refpoints)
            % calculates min distance from point and either obj.idxpoints or refpoints
            
            
            
            if nargin == 2  %
                
                indexes = obj.track_11+1;
                dist = sum((point - obj.idxpoints(indexes,:)).^2, 2);
                
            end
            
            
            if nargin == 3  % if reference points are specified
                
                dist = sum((point - refpoints).^2, 2);
                
            end
            
            
            dist = min(dist);  %rank is based on max of min distance i.e. point furthest away from everything
            
            
        end
        
        
        function rank(obj) %#ok<MANU>
            %function to rank points based on distance
            

            
            
            
            
        end

        
    %plotting -------------------------------------------------------------
        function plotscatter(obj)  
            % scatter plot showing ivo/evc points and camtrack as defined by
            % idx points.  if idxpoints are not defined an error is thrown.
            
            plot(obj.points.VCT_CAM_ACT_INT, obj.points.VCT_CAM_ACT_EXH, '+');
            title('Cam position over cycle');
            xlabel('int'); ylabel('exh'); hold on;
            
            %plot cam track
            plot(obj.idxpoints(obj.track_11 + 1, 1), obj.idxpoints(obj.track_11 + 1, 2), 'r', 'LineWidth', 2); hold off;
        
        end
        
        
        function plotiris(obj)  %#ok<MANU>
            % plot showing central point and circle with radius
            % representing distance of furthest point from centre.
            
        end
        
        
        
        function plotarea(obj)  %#ok<MANU>
           %plot showing area covered by clusters of points relative to total 
           % area covered by all points.
            
        end
        
        
        
        function optiacov(obj, target) %#ok<INUSD>
           %method to optmise numberofpoints to cover target percentage
           %of the area enclosing all of the measured ivo/evc points.
            
            
        end
        
        
    % get and set methods for dependant properties -----------------------
        
        function obj = get.centres(obj)
            
            %obj.centres = something
            
        end
        
    end
    
    
    
    
    
    % static methods (not sure if we need these) --------------------------
    methods(Static)
        
                

        
        
    end
     
    
    
end