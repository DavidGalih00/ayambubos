-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 13, 2022 at 09:13 AM
-- Server version: 5.7.33
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ayam_bubos`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id_customer` varchar(20) NOT NULL,
  `nama_customer` varchar(100) NOT NULL,
  `jk_customer` enum('Laki-Laki','Perempuan') NOT NULL,
  `alamat_customer` varchar(200) NOT NULL,
  `email_customer` varchar(100) NOT NULL,
  `telp_customer` varchar(20) NOT NULL,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_customer`, `nama_customer`, `jk_customer`, `alamat_customer`, `email_customer`, `telp_customer`, `deleted`) VALUES
('CUS-1', 'david', 'Laki-Laki', 'Temanggung', 'ddavid@gmail.com', '08614258712', 0);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` varchar(20) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `deleted`) VALUES
('K-1', 'Ayam', 0),
('K-2', 'Lele', 0),
('K-3', 'Mie', 0),
('K-4', 'Bakso', 0);

-- --------------------------------------------------------

--
-- Table structure for table `makanan`
--

CREATE TABLE `makanan` (
  `id_makanan` varchar(50) NOT NULL,
  `nama_makanan` varchar(200) NOT NULL,
  `id_kategori` varchar(20) NOT NULL,
  `stok` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `deskripsi` varchar(1000) NOT NULL,
  `gambar` varchar(200) NOT NULL,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `makanan`
--

INSERT INTO `makanan` (`id_makanan`, `nama_makanan`, `id_kategori`, `stok`, `harga`, `deskripsi`, `gambar`, `deleted`) VALUES
('M-1', 'Ayam Suwir', 'K-1', 15, 12000, 'Potongan ayam + sambel ijo', 'ayam suwir.jpeg', 0),
('M-2', 'Chicken Katsu', 'K-1', 10, 17000, 'Chicken katsu yang memiliki nama asli tori katsu ini adalah hidangan asal Jepang yang hits dan digemari banyak orang.', 'chiken katsu.jpeg', 0),
('M-3', 'Ayam Cabai Garam', 'K-1', 20, 15000, 'Ayam dengan toping', 'ayam cabe garam.jpeg', 0),
('M-4', 'Ayam Geprek Pete Sambel Ijo', 'K-1', 2, 16000, 'Ayam Geprek dengan ekstra pete', 'ayam geprek pete sambel ijo.jpeg', 0),
('M-5', 'Lele Goreng', 'K-2', 5, 10000, 'Lele tepung goreng', 'lele goreng.jpeg', 0),
('M-6', 'Ayam Lada Hitam', 'K-1', 5, 15000, 'Ayam toping lada hitam', 'ayam lada hitam.jpeg', 0),
('M-7', 'Mie Level', 'K-3', 8, 11000, 'Mie pedas', 'mie level.jpeg', 0),
('M-8', 'Rica Ayam', 'K-1', 10, 17000, 'Rica-rica Ayam', 'rica ayam.jpeg', 0),
('M-9', 'Ayam Geprek Sambel Bawang', 'K-1', 13, 15000, 'Ayam Geprek level dengan sambel bawang', 'ayam geprek sambel bawang.jpeg', 0),
('M-10', 'Ayam Geprek Sambel Ijo', 'K-1', 8, 12000, 'Ayam Geprek dengan sambel ijo', 'ayam geprek sambel ijo.jpeg', 0),
('M-11', 'Ayam Geprek Sambel Matah', 'K-1', 20, 11000, 'Ayam Geprek dengan sambal matah', 'ayam geprek sambel matah.jpeg', 0),
('M-12', 'Spicy Wings', 'K-1', 4, 17000, 'sayap ayam dengan bumbu pedas', 'spicy wings.jpeg', 0),
('M-13', 'Sop Ayam', 'K-1', 20, 12000, 'Sop Ayam', 'spo ayam.jpeg', 0),
('M-14', 'Bakso Pedas', 'K-4', 1, 13000, 'Bakso daging ayam', 'bakso pedas.jpeg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` varchar(50) NOT NULL,
  `id_customer` varchar(20) NOT NULL,
  `id_makanan` varchar(50) NOT NULL,
  `tgl_transaksi` datetime NOT NULL,
  `jumlah` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_customer`, `id_makanan`, `tgl_transaksi`, `jumlah`, `total`) VALUES
('TR-1', 'CUS-1', 'M-2', '2022-01-13 16:11:02', 1, 17000);

--
-- Triggers `transaksi`
--
DELIMITER $$
CREATE TRIGGER `makanan_baru` AFTER DELETE ON `transaksi` FOR EACH ROW BEGIN
	UPDATE makanan SET stok=stok+OLD.jumlah WHERE id_makanan=OLD.id_makanan;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `tipe_user` enum('Customer','Admin') NOT NULL,
  `id_customer` varchar(20) DEFAULT NULL,
  `deleted` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `tipe_user`, `id_customer`, `deleted`) VALUES
('amdin', 'amin', 'Admin', '', 0),
('dapid', 'beban', 'Customer', 'CUS-1', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
