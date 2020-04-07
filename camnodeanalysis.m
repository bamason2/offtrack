classdef camnodeanalysis <camplot
    % Aim: Identify test points for measurement of off track performance.
    % 1)	Identify the x furthest points away from camtrack indices
    % 2)	Cluster the neighbourhood of points around each centroid x
    % 3)	Plot each off track cluster against the camtrack
    
    
    %changelog
    %----------------------------------------------
    %07APR20         BM      Initial specification.

    
    
    
    
    
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
                       
    end
        
end



