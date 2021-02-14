# Digital-electronics-1
### H3 text


**Source code**
```vhld
impure function rand_real(min_val, max_val : real) return real is
  variable r : real;
begin
  uniform(seed1, seed2, r);
  return r * (max_val - min_val) + min_val;
end function;

```
