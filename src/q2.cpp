/* Calculating linear regression coefficients */

#include <iostream>
#include <stdio.h>
#include <vector>

int main()
{
  int n; //# of features
  std::vector<float> x,y; //data vectors
  
  //input stuff
  std::cout << "Specify the length of vectors: ";
  std::cin >> n;

  std::cout << "Input values for x vector, separated by <space>: ";
  for (int i = 0; i < n; i++) {
    float t;
    std::cin >> t;
    x.push_back(t);
  }

  std::cout << "Input values for y vector, separated by <space>: ";
  for (int i = 0; i < n; i++) {
    float t;
    std::cin >> t;
    y.push_back(t);
  }

  //calculating sample means:
  float m_x, m_y; //sample means
  float s_x = 0,s_y = 0;
  
  for (int i = 0; i < n; i++) {
    s_x += x[i];
    s_y += y[i];
  }

  m_x = s_x / n;
  m_y = s_y / n;
  std::cout << std::endl;
  std::cout << "mean <m_x>: " << m_x << std::endl;
  std::cout << "mean <m_y>: " << m_y << std::endl;

  std::cout << std::endl;
  std::cout << "<x>" << "\t" << "<y>" << "\t" << "<x_d>" << "\t" << "<y_d>" << "\t" << "<x_d^2>"  << "\t" << "<x_d*y_d>" << std::endl;
  
  //calculating vectors
  std::vector<float> x_diff, x_diff_sq,y_diff,diff_prod;
  float sum_diff_prod = 0,sum_x_diff_sq = 0;
  for (int i = 0; i < n; i++) {
    x_diff.push_back(x[i] - m_x);
    y_diff.push_back(y[i] - m_y);
    diff_prod.push_back(x_diff[i]*y_diff[i]);
    x_diff_sq.push_back(x_diff[i]*x_diff[i]);

    sum_diff_prod += diff_prod[i];
    sum_x_diff_sq += x_diff_sq[i];
    
    //print out vectors
    std::cout << x[i] << "\t" << y[i] << "\t" << x_diff[i] << "\t" << y_diff[i] << "\t" << x_diff_sq[i] << "\t" << diff_prod[i]  << std::endl;
  }

  std::cout << std::endl;

  //calculaing b1
  float b1;
  b1 = sum_diff_prod / sum_x_diff_sq;
  std::cout << "<b1>: " << b1 << std::endl;
  
  //calculating b0
  float b0 = m_y - b1 * m_x;
  std::cout << "<b0>: " << b0 << std::endl;
    
  return 0;
}
