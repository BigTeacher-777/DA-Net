

path = ['F:\CVPR2018_CrowdCounting\data\processed_no_augmentation\zzk_roi_train\image\'];
gt_path = ['F:\CVPR2018_CrowdCounting\data\processed_no_augmentation\zzk_roi_train\ground_truth\'];
train_path_img = strcat('F:\CVPR2018_CrowdCounting\data\processed_no_augmentation\zzk_roi_train\process_image\');
train_path_den = strcat('F:\CVPR2018_CrowdCounting\data\processed_no_augmentation\zzk_roi_train\process_ground_truth\');

mkdir(train_path_img);
mkdir(train_path_den);

img_path_list = dir(strcat(path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������

for j = 1:img_num %��һ��ȡͼ��
    image_name = img_path_list(j).name;% ͼ����
    im =  imread(strcat(path,image_name));
    [h, w, c] = size(im);
    if (c == 3)
        im = rgb2gray(im);
    end
    
    len = length(image_name)
    label = image_name(1:len-4)
    
    label_path = image_name(1:6)
    
    if ~exist(strcat(gt_path,label_path,label_path,'\'))
        mkdir(strcat(gt_path,label_path,label_path,'\'))
    end
    A = load(strcat(gt_path,label_path,'\',label,'.mat')) ;
    annPoints =  A.density;
    %annPoints =  image_info{1}.location;


    im_density = get_density_map_gaussian(im,annPoints);
    imwrite(im, [train_path_img image_name]);
    csvwrite([train_path_den label '.csv'], im_density);
   % fprintf('%d %d %s\n',i,j,image_name);% ��ʾ���ڴ����ͼ����
    %ͼ������� ʡ��
end

    


    
    
   