classdef SymVariable < Variable
  % SYMVARIABLE Variable arithmetic operations for Matlab symbolic 
  % toolbox variables
  
  properties
  end
  
  methods (Static)
    
    function obj = Matrix(sizeIn)
      obj = SymVariable(MatrixStructure(sizeIn));
    end
    
  end
  
  methods
    
    function self = SymVariable(varStructure,value)
      
      self = self@Variable(varStructure);
      
      if prod(varStructure.size) == 0
        return
      end

      if nargin == 1
        value = sym(varStructure.id,[prod(varStructure.size),1]);
        assume(value,'real');
      end
      
      if isa(value,'Value')
        self.thisValue = value;
      else
        self.thisValue.set(value);
      end
      
    end
    
    function v = polyval(p,a)
      if isa(p,'Variable') 
        self = p;
        p = p.value;
      end  
      if isa(a,'Variable')
        self = a;
        a = a.value;
      end
      
      % Use Horner's method for general case where X is an array.
      nc = length(p);
      siz_a = size(a);
      y = zeros(siz_a);
      if nc>0, y(:) = p(1); end
      for i=2:nc
        y = a .* y + p(i);
      end
    
      v = Variable.createMatrixLike(self,y);
    end
    
    
  end
  

  
end
