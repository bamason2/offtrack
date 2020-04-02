classdef camplot
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        
        
    end
    
    
    
    methods
        
        function plotscatter(obj, type)
            % scatter plot showing ivo/evc points and camtrack as defined by
            % idx points.  if idxpoints are not defined an error is thrown.
            
            hold on;
            
            switch type
                
                case 'act'
                    
                    
                    plot(obj.cam_act.nodes(:,1),obj.cam_act.nodes(:,2), '+');
            
                case 'target'
                    
                    plot(obj.cam_target.nodes(:,1),obj.cam_target.nodes(:,2), '+');
            end
            
            
            title('Cam position over cycle');
            xlabel('int'); ylabel('exh'); 
            
            hold off;
            
        end
        
        function plottrack(obj)
            
            %plot cam track
            hold on;
            title('Cam position over cycle');
            xlabel('int'); ylabel('exh'); 
            plot(obj.cam_track.nodes(:,1), obj.cam_track.nodes(:,2), 'r', 'LineWidth', 2);
            hold off;
            
            
        end
        
        function circleplot(~, centrepoint, radiuspoint)
            %plot a circle at point specified by centrepoint of radius
            %equal to the distance between the centrepoint and radiuspiont
            
            
            r = sqrt(sum(centrepoint - radiuspoint).^2);
            
            theta = 0:pi/50:2*pi;
            xunit = r * cos(theta) + centrepoint(1);
            yunit = r * sin(theta) + centrepoint(2);
            
            hold on
            plot(xunit, yunit);
            hold off
            
        end
        
        
        function plotiris(obj)  %#ok<MANU>
            % plot showing central point and circle with radius
            % representing distance of furthest point from centre.
            
        end
        
        
        function plotpointsonscatter(obj, points)
            
            obj.plotscatter(); hold on;
            plot(points(:,1), points(:,2), '*', 'MarkerSize', 12); hold off
            
            
        end
        
        
        function plotarea(obj)  %#ok<MANU>
            %plot showing area covered by clusters of points relative to total
            % area covered by all points.
            
        end
        
        
        
        function optiacov(obj, target) %#ok<INUSD>
            %method to optmise numberofpoints to cover target percentage
            %of the area enclosing all of the measured ivo/evc points.
            
            
        end
    end
end

