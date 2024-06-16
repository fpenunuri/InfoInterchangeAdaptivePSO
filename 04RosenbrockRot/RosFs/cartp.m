%cartesian product
%for instance cartp([0,1],[0,1])=[0,0;1,0;0,1;1,1]
function localf = cartp(varargin)
  [localf{1:nargin}] = ndgrid (varargin{:});
  localf = cat (nargin+1, localf{:});
  localf = reshape (localf, [], nargin);
end
