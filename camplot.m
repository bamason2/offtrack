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
        
        
        function ploterror(obj, arg)
            %plots some error metrics comparing target cam position with
            %actual cam position.
            
            if nargin == 1
                
               arg = 'magnitude';
               
            end
            
            
            switch arg
                
                    case 'ivo'
                    
                    error = obj.cam_act.nodes(:,1) - obj.cam_target.nodes(:,1);
                    plt_title = 'IVO error';
                    
                case 'evc'
                    
                    error = obj.cam_act.nodes(:,2) - obj.cam_target.nodes(:,2);
                    plt_title = 'EVC error';
                    
                    
                    
                case 'magnitude' 
                           
                    error = vecnorm(obj.cam_act.nodes - obj.cam_target.nodes, 2, 2);
                    plt_title = 'Magnitude error';
                    
                    
                    
            end
           
            
            
            figure; hold on;
            nexttile;
            plot(error);
            title([plt_title, ' over run']);
            xlabel('sample #');
            
            nexttile; 
            histogram(error);
            title([plt_title, ' distribution'])
            
            nexttile; 
            normplot(error);
            title([plt_title, ' normal plot']);
            
        end
        
        
        function fiterrordist(obj, arg)
            
            if nargin == 1
                
                arg = 'magnitude';
                
            end
            
            
            switch arg
                
                case 'ivo'
                    
                    camerror = obj.cam_act.nodes(:,1) - obj.cam_target.nodes(:,1);
                    plt_title = 'IVO error';
                    
                case 'evc'
                    
                    camerror = obj.cam_act.nodes(:,2) - obj.cam_target.nodes(:,2);
                    plt_title = 'EVC error';
                    
                    
                    
                case 'magnitude'
                    
                    camerror = vecnorm(obj.cam_act.nodes - obj.cam_target.nodes, 2, 2);
                    plt_title = 'Magnitude error';
                    
                    
                    
            end
            
            WeibDist = fitdist(abs(camerror),'weibull');
            NormDist = fitdist(camerror,'normal');
            LogDist = fitdist(camerror,'logistic');
            KerDist = fitdist(camerror,'kernel');
            TDist = fitdist(camerror,'tLocationScale');
            
            x = min(camerror):max(camerror);
            pdf_Wei = pdf(WeibDist,x);
            pdf_Norm = pdf(NormDist,x);
            pdf_Log = pdf(LogDist,x);
            pdf_Ker = pdf(KerDist,x);
            pdf_T = pdf(TDist,x);
            
            figure
            histogram(camerror,'Normalization','pdf');
            
            line(x,pdf_Wei, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 2)
            line(x,pdf_Norm, 'Color','g', 'LineStyle', '--', 'LineWidth', 2)
            line(x,pdf_Log, 'Color', 'b', 'LineStyle', '-.', 'LineWidth', 2)
            line(x,pdf_Ker, 'Color','c', 'LineStyle', ':', 'LineWidth', 2)
            line(x,pdf_T, 'Color','m', 'LineStyle', '-', 'LineWidth', 2)
            legend('Data','Weibull','Normal','Logistic','Kernel','T','Location','Best')
            title(plt_title)
            xlabel('error')
            
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

