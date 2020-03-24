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
            fields = {'VCT_CAM_ACT_EXH', 'VCT_CAM_ACT_INT'};
            
            data = load(inputdata);
            
            obj.points = table(data.(fields{1}).signals.values, data.(fields{2}).signals.values, 'VariableNames', {fields{1}, fields{2}});
        
        
        end

        
        function distance(obj, x, y) %#ok<INUSD>
            % calculates distance between point x and y accepts an array as
            % arguments.  if x is a array a distance is calculated for
            % each point in the array relative to the point or group of
            % points specfied by y.  if a single argument is entered as a
            % array or scalar x then the distance is calculated with
            % reference to the index points.
            
            switch nargin
                
                case nargin == 2
                    %case when only one set of points is provided
                    %(comparison is by default with idxpoints).  all points
                    %in x are compared individually with the idxpoints
                    
                    
                case nargin == 3
                    %case when two sets of points are provided.  all individual 
                    %points within x are compared with the group of points
                    %represented by y.
            end
            
        end
        
        
        function rank(obj) %#ok<MANU>
            %function to rank points based on distance
            

        end

        
    %plotting -------------------------------------------------------------
        function plotscatter(obj)  
            % scatter plot showing ivo/evc points and camtrack as defined by
            % idx points.  if idxpoints are not defined an error is thrown.
            
            plot(obj.points.VCT_CAM_ACT_INT, obj.points.VCT_CAM_ACT_EXH, '+')
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
        
        
        
    % get and set methods for dependant properties -----------------------
        
        function obj = get.centres(obj)
            
            %obj.centres = something
            
        end
        
    end
    
    
    
    % static methods (not sure if we need these) --------------------------
    methods(Static)
        
        
        
        
    end
     
    
    
end