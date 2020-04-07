classdef camplot < handle
    % plotting functionality for camnodepath class
    
    properties
        
        
        
    end
    
    
    
    methods
        
        function plotfarcluster(obj, track, N)
        
        
            cluster = obj.farcluster(track, N);
            
            hold on;
            
            for i = 1 : length(cluster)
                
                plot(cluster(i).points(:,1), cluster(i).points(:,2), '+')
                
            end
            
            hold off;
            
            
            title('farcluster');
            xlabel('int [degrees from lock pos]'); ylabel('exh [degrees from lock pos]'); 
            
        end
        
        
        function plotscatter(obj)
            % scatter plot showing ivo/evc points and camtrack as defined by
            % idx points.  if idxpoints are not defined an error is thrown.
            
            hold on;
                                                    
            plot(obj.nodes(:,1),obj.nodes(:,2), '+'); %#ok<MCNPN>
            
            title('Cam position over cycle');
            xlabel('int [degrees from lock pos]'); ylabel('exh [degrees from lock pos]'); 
            
            hold off;
            
        end
        

        
        function plottrack(obj)
            %plot cam track
            
            hold on;
            
            plot(obj.nodes(:,1), obj.nodes(:,2), 'r', 'LineWidth', 2); %#ok<MCNPN>
            
            title('Cam position over cycle');
            xlabel('int [degrees from lock pos]'); ylabel('exh [degrees from lock pos]'); 

            
            hold off;
            
            
        end
        
        
        function plotkmeans(obj, N)
            
            
            cluster = obj.kmeans(N);
            
            hold on;
                     
            for i = 1 : length(cluster)
            
                plot(cluster(i).points(:,1), cluster(i).points(:,2), '+'); 
            
            end
                        
            title('kmeans');
            xlabel('int'); ylabel('exh'); 
            
            hold off;
            
        end
        
        
    end
    
    
%         methods (Static)
%             
%            
%             function plotfig(cluster, title, xlabel, ylabel, line)
%             
%                 
%                 
%                 
%             end
%             
%         end
        

    
end

