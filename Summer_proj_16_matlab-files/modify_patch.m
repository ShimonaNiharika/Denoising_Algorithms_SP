function out = modify_patch(patch, search_wind,sim_wind)

[m,n] = size(patch);

[r,c] = size(search_wind);

%create dictionary for searching

no_patches = (r/sim_wind)*(c/sim_wind);

patch_temp = search_wind(1:sim_wind,1:sim_wind);
search_dictionary = reshape(patch_temp,[1,sim_wind^2]);

horz_patch = c/sim_wind;
vert_patch = r/sim_wind;

for i = 1: vert_patch
    for j = 1: horz_patch
   
    patch_temp = search_wind((i-1)*sim_wind+1:(i-1)*sim_wind+sim_wind,(j-1)*sim_wind+1:(j-1)*sim_wind+sim_wind);
    patch_flat = reshape(patch_temp,[1,sim_wind^2]);
    search_dictionary = vertcat(search_dictionary,patch_flat);
   
    end
end
search_dictionary = (search_dictionary(2:end,:));

%create storage for patch_features
patch_temp = patch(1:sim_wind,1:sim_wind);
patch_dictionary = reshape(patch_temp,[1,sim_wind^2]);
horz_patch_p = n/sim_wind;
vert_patch_p = m/sim_wind;

for i = 1: vert_patch_p
    for j = 1: horz_patch_p
   
    patch_temp = patch((i-1)*sim_wind+1:(i-1)*sim_wind+sim_wind,(j-1)*sim_wind+1:(j-1)*sim_wind+sim_wind);
    patch_flat = reshape(patch_temp,[1,sim_wind^2]);
    patch_dictionary = vertcat(patch_dictionary,patch_flat);
   
    end
end
patch_dictionary = (patch_dictionary(2:end,:));

numel = size(patch_dictionary,1);
v = 1;
switch v
    case 0
     for i = 1:numel
      %patch_dictionary(i,:) = create_weighted_patch(patch_dictionary(((numel-1)/2)+1,:),search_dictionary,i,m/sim_wind,r/sim_wind);
      patch_dictionary(i,:) = create_weighted_patch(patch_dictionary(i,:),search_dictionary,i,m/sim_wind,r/sim_wind);
     end
    case 1
      patch_dictionary_mod = create_weighted_patch_2(patch_dictionary(((numel-1)/2)+1,:),search_dictionary,sim_wind);
end

%patch_dictionary = patch_dictionary(:);
% % for i = 1:size(patch_dictionary,1)
% %  pd_1(i,:,:) = reshape(patch_dictionary(i,:),[3,3]);
% % end
% % out = reshape(pd_1,[m,n]);

out = patch_reconst(patch_dictionary_mod,size(patch,1),size(patch,2),sim_wind);

end