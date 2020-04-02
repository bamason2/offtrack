classdef camnodeanalysis <camplot
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
    %                        obj.points. added some plotting methods.
    
    
    
    
    
    properties
        
        cam_act
        cam_target
        cam_track
        
    end
    
    
    properties (Dependent)
        
        centres             %list of point centres and cluster of points around these
        
        
        
    end
    
    
    
    methods
        
        function obj = camnodeanalysis(datafile, trackdata)
            %constructor method creates cam position (actual and target) and cam track linked
            %lists as structures.
            
            
            %create object array of camtrack indexes
            camloc = readmatrix(trackdata);
                        
            obj.cam_track = camnodepath(camloc);
                       

            %create object array of cam positions (act)
            data = load(datafile);
            
            ivo = data.VCT_CAM_ACT_INT.signals.values;
            evc = data.VCT_CAM_ACT_EXH.signals.values;
            obj.cam_act = camnodepath([ivo, evc]);
                
                        
            %create object array of cam positions (target)
            ivo = data.VCT_INT_CTRL_TARGET.signals.values;
            evc = data.VCT_EXH_CTRL_TARGET.signals.values;
            obj.cam_target = camnodepath([ivo, evc]);
                
       

            
        end
        
        
        function out = collectpoints(obj)
           %algorith to find furthest point (max of minimum distance from a 
           %track index point) and obtain a cluster a number of n points
           %around this.  Repeat the process until all points are accounted
           %for.
            
           %get distances of all points from index points
           
           
            
        end
        
        
        function idx = getfurthest(obj, points)
            %function to evaluate distance between obj.points and
            %obj.idxpoints. if points argument is supplied then points is
            %compared with obj.idxpoints.
            
            
            idx = find(distances == max(distances));
            
        end
        
        
        
        function dist = dist(obj, point, refpoints)
            % calculates min distance from point and either obj.idxpoints or refpoints
            
            
            if nargin == 2  %
                
                indexes = obj.track_11+1;
                dist = sum((point - obj.idxpoints(indexes,:)).^2, 2);
                
            end
            
            
            if nargin == 3  % if reference points are specified
                
                dist = sum((point - refpoints).^2, 2);
                
            end
            
            
        end
        
        
        function idx = findnearestidx(obj, point, numberofpoints)
            % return
            
            all_points = obj.points{:,:};
            
            distances = obj.dist(point, all_points);
            sorteddistances = sort(distances, 'ascend');
            subsetdistances = sorteddistances(1:numberofpoints, :);
            
            
            idx = find(ismember(distances, subsetdistances, 'rows'));
            
            
        end
        
        
        function idx = maxidxdist(obj)
            % function to find distance of nearest index point
            
            all_points = obj.points{:,:};
            
            distances = obj.dist(point, all_points);
            sorteddistances = sort(distances, 'ascend');
            subsetdistances = sorteddistances(1:numberofpoints, :);
            
            
            idx = find(ismember(distances, subsetdistances, 'rows'));
            
            
        end
        
        
        function idx = findfurthest(obj, point, refpoints)
            % function to return the index in refpoints of the furthest
            % point in refpoint from point.
            
            distances = obj.dist(point, refpoints);
            maxdistance = max(distances);
            
            
            idx = find(maxdistance == distances);
            
            
        end
                
    end
    
    
    
    % static methods (not sure if we need these) --------------------------
    methods(Static)
        
        
        function out = pos(nodes)
            %return position of nodes as vector
            
            fields = fieldnames(nodes);
            out = zeros(length(fields), 2);
            
            for i = 1:length(fields)
                out(i,:) = nodes.(fields{i}).Data;
                
            end
            
        end
        
        
    end
    
    
end



