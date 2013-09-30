% Using raw pics data 
import_pics('data\pics.mat')

[pc,score,latent,tsquare] = princomp(pics);

%cumsum(latent)./sum(latent)
avg_error = [];

num_pcs = 399;

figure

subplot(1,2,1);
img_in = pics(1,:);
img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
img_in_disp = reshape(img_in_disp,56,46);
imshow(img_in_disp);

error = [];

pc_indices = [];
for i=cum(1):0.05:1,
    ind = max(find(cum<=i));
    pc_indices = [pc_indices ind];
end

for ind=pc_indices

    enc = pics(:,:) * pc(:,1:ind);
    dec = enc * pc(:,1:ind)';
    
    avg_error = [avg_error mse_error(pics,dec)];
end

min_ = min(avg_error);
index_min = find(avg_error==min_);

ind = pc_indices(index_min);
enc = pics(:,:) * pc(:,1:ind);
dec = enc * pc(:,1:ind)';

subplot(1,2,2);
img_in = dec(1,:);
img_in_disp = sum(abs(img_in).^2, 3).^0.5;
img_in_disp = img_in_disp./max(img_in_disp(:));
img_in_disp = reshape(img_in_disp,56,46);
imshow(img_in_disp);
    
figure
plot(pc_indices, avg_error)
