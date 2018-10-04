function [Pose] = compute_relative_pose( RestPose, CurrentPose )
Pose = celfun(@(r,c) c/r,RestPose,CurrentPose,'UniformOutput',false);
end