function [ DelayedCroppedSamples ] = DelayandCropSamples( DistanceIndexMatrix, M, CenterElementNum, NumbSamples, numElements_HalfAperture, NumbLines )
%Applies time delays and crops samples to give matrix with cropped and
%delayed samples

%% Find Cropping Amount in Number of Samples
% Cropping is applied such that 50% of the maximum time delay number of
% indices computed in the DistanceIndexMatrix is used as the cropping value
NumSamplesToCrop = floor(max(max(DistanceIndexMatrix))/2);

% Compute how many samples to include in cropped data
NumIncludedSamples = NumbSamples - NumSamplesToCrop;

%% Find Number of Included Elements in Aperture
NumIncludedElementsAperture = 2*numElements_HalfAperture + 1;

%% Loop to Delay and Crop Samples for each Beam
DelayedCroppedSamples = zeros(NumIncludedSamples,NumIncludedElementsAperture, NumbLines); % preallocate for speed
for beamIndex = 1:NumbLines
    FirstApertureElement = CenterElementNum(beamIndex)-numElements_HalfAperture; % computes element number of first element included in aperture
    for ApertureElementIndex = 1:NumIncludedElementsAperture
        delay = DistanceIndexMatrix(FirstApertureElement,beamIndex);
        for SampIndex = 1:NumIncludedSamples
            DelayedCroppedSamples(SampIndex,ApertureElementIndex,beamIndex) = M(  delay-1+SampIndex, ...
                                                            FirstApertureElement-1+ApertureElementIndex,...
                                                            beamIndex); 
        end
    end

end
