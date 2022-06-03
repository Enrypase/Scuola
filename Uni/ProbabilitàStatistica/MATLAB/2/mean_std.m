function[media, sdv] = mean_std(input)
    sumElements = sum(input);
    media = sumElements / length(input);

    sdv = sqrt(sum((input - media).^ 2) / (length(input) - 1));
end