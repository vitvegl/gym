update exercise e join equipment eq on eq.id = e.id
  set eq.equipment = 'власна вага'
    where e.weight_kg = 0;
